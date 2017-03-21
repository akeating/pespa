import Vue from 'vue';
import store from '../store';
import localStorage from './localStorage';

export default {
  isAuthenticated,
  exchangeCredentialsForToken,
  whoami,
  localStorage
};

function isAuthenticated() {
  let authenticated = store.state.currentUser && store.state.currentUser.user !== null;
  if (!authenticated) {
    const token = localStorage.getToken();
    if (token) {
      return store.dispatch('whoami', { token })
        .then((user) => true)
        .catch(() => false);
    }
  }
  return Promise.resolve(authenticated);
}

function exchangeCredentialsForToken({ email, password }) {
  return sendJson('/api/token', { email, password }).then(token => {
    if (!token) {
      throw new Error('No token received');
    }
    return token;
  });
}

function whoami({ token }) {
  const options = {
    headers: { Authorization: token }
  };
  const query = `{ whoami {
    id, name, email
  }}`;
  return sendJson('/api/graphql', { query }, options).then(data => {
    return data.whoami;
  });
}

function sendJson(url, body, options) {
  return Vue.http.post(url, body, options)
    .then((httpResponse) => httpResponse.json())
    .then(json => json.data);
}

// function getJson(url, options) {
//   return Vue.http.get(url, options)
//     .then((httpResponse) => httpResponse.json())
//     .then(json => json.data);
// }
