import 'bootstrap-loader';
import './styles.scss';

// https://github.com/elm-community/elm-webpack-loader/issues/149
import { Elm } from './Main';

const app = Elm.Main.init({
  node: document.getElementById('root'),
});

app.ports.authenticate.subscribe(email => {
  app.ports.handleAuthenticate.send({ email });
});
