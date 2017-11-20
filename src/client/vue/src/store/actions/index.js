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
    return api.incrementCountBy({ token, by }).then(({ version, count }) => {
      commit('countChanged', { version, count });
      return { version, count };
    });
  },

  connect: ({ commit, state }) => {
    const token = state.token;
    const onError = (x) => {
      // x.message = "connection: close"
      commit('connected', false);
    };

    const onStart = (x) => {
      // detailed subscrpition info
      // implied connection: open
      commit('connected', true);
    };

    return api.connect({ token, onError, onStart });
  },

  subscribeToCountChanged: ({ commit, state }) => {
    const query = `
    subscription CountChanged {
      countChanged {
        count
        version
      }
    }`;
    const variables = {};
    const handler = ({ result }) => {
      const { count, version } = result.data.countChanged;
      commit('countChanged', { count, version });
    };
    return api.subscribe({ query, variables, handler });
  },

  logout: ({ commit }) => {
    return Promise.resolve().then(() => {
      api.localStorage.clearToken();
      commit('currentUser', { user: null, token: null });
    });
  }
};
