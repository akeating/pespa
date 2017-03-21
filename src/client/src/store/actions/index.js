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

  logout: ({ commit }) => {
    return Promise.resolve().then(() => {
      api.localStorage.clearToken();
      commit('currentUser', { user: null, token: null });
    });
  }
};
