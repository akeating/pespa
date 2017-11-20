import { http } from 'vue';
import store from '../store';
import localStorage from './localStorage';
import newClient from './client';
import gql from 'graphql-tag';

export default {
  isAuthenticated,
  exchangeCredentialsForToken,
  whoami,
  localStorage,
  incrementCountBy,
  connect,
  subscribe
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

function connect({ token, onError, onStart }) {
  const opts = { params: { token }, onError, onStart };
  this.client = newClient(opts);
  return Promise.resolve();
}

function subscribe({ query, variables, handler, onError, onStart }) {
  this.client.subscribe({ query: gql`${query}`, variables }).subscribe({
    next(result) { handler({ result }); },
    error(err) { console.log(`Finished with error: ${err}`); },
    complete() { console.log('Finished'); }
  });
}

function incrementCountBy({ token, by }) {
  const options = {
    headers: { Authorization: token }
  };
  const query = `mutation IncrementCountBy($by: Int) {
    incrementCountBy(by: $by) {
      count
      version
    }
  }`;
  const variables = { by };
  return sendJson('/api/graphql', { query, variables }, options).then(data => {
    return data.incrementCountBy;
  });
}

function sendJson(url, body, options) {
  return http.post(url, body, options)
    .then((httpResponse) => httpResponse.json())
    .then(json => json.data);
}

// function getJson(url, options) {
//   return Vue.http.get(url, options)
//     .then((httpResponse) => httpResponse.json())
//     .then(json => json.data);
// }
