import api from '../../api';

export default {

  exchangeCredentialsForToken: ({ commit }, { email, password }) => {
    return api.exchangeCredentialsForToken({ email, password });
  },

  whoami: ({ commit }, { token }) => {
    return api.whoami({ token }).then((user) => {
      commit('currentUser', { user, token });
      return user;
    });
  },

  incrementCountBy: ({ commit, state }, { by }) => {
    const token = state.token;
    return api.incrementCountBy({ token, by }).then(count => {
      commit('countChanged', { count });
      return count;
    });
  },

  connect: ({ commit, state }) => {
    const token = state.token;
    return api.connect({ token }).then(() => {
      commit('onlineStatusChange', true);
    }).catch(() => {
      commit('onlineStatusChange', false);
    });
  },

  logout: ({ commit }) => {
    return Promise.resolve().then(() => {
      api.localStorage.clearToken();
      commit('currentUser', { user: null, token: null });
    });
  }
};
