import 'bootstrap-loader';
import './styles.scss';

// https://github.com/elm-community/elm-webpack-loader/issues/149
import { Elm } from './Main';

import * as AbsintheSocket from "@absinthe/socket";
import { Socket as PhoenixSocket } from "phoenix";

let notifiers = [];

document.addEventListener("DOMContentLoaded", () => {
  const absintheSocket = AbsintheSocket.create(
    new PhoenixSocket("ws://localhost:3000/socket")
  );

  const app = Elm.Main.init({
    node: document.getElementById('root'),
  });

  app.ports.createSubscriptions.subscribe(subscription => {
    console.log("createSubscriptions called with", [subscription]);
    // Remove existing notifiers
    notifiers.map(notifier => AbsintheSocket.cancel(absintheSocket, notifier));

    // Create new notifiers for each subscription sent
    notifiers = [subscription].map(operation =>
      AbsintheSocket.send(absintheSocket, {
        operation,
        variables: {}
      })
    );

    function onStart(data) {
      console.log(">>> Start", JSON.stringify(data));
      app.ports.socketStatusConnected.send(null);
    }

    function onAbort(data) {
      console.log(">>> Abort", JSON.stringify(data));
    }

    function onCancel(data) {
      console.log(">>> Cancel", JSON.stringify(data));
    }

    function onError(data) {
      console.log(">>> Error", JSON.stringify(data));
      app.ports.socketStatusReconnecting.send(null);
    }

    function onResult(res) {
      console.log(">>> Result", JSON.stringify(res));
      app.ports.gotSubscriptionData.send(res);
    }

    notifiers.map(notifier =>
      AbsintheSocket.observe(absintheSocket, notifier, {
        onAbort,
        onError,
        onCancel,
        onStart,
        onResult
      })
    );
  });
});
