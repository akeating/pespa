import * as AbsintheSocket from '@absinthe/socket';
import {createAbsintheSocketLink} from '@absinthe/socket-apollo-link';
import {Socket as PhoenixSocket} from 'phoenix';

export default function({ onError, onStart, ...socketOpts }) {
  return createAbsintheSocketLink(AbsintheSocket.create(
    new PhoenixSocket('/socket', socketOpts)
  ), onError, onStart);
}
