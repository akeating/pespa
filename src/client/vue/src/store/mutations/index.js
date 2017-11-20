import * as _ from 'lodash';

export default {

  // { { id, email, name }, token }
  currentUser(state, { user, token }) {
    if (user) {
      state.currentUser = _.pick(user, [ 'id', 'email', 'name' ]);
      state.token = token;
    } else {
      state.currentUser = null;
      state.token = null;
    }
  },

  countChanged(state, { count, version }) {
    state.counter = { count, version };
  },

  connected(state, value) {
    state.connected = value;
  }
};
