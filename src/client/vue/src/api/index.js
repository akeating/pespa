import { http } from 'vue';
import store from '../store';
import localStorage from './localStorage';
import Client from 'absinthe-phoenix/index';

export default {
  isAuthenticated,
  exchangeCredentialsForToken,
  whoami,
  localStorage,
  incrementCountBy,
  connect
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

function connect({ token }) {
  const options = { params: { token } };
  const client = new Client('/socket', options);
  return client.connect().then(() => subscribe(client));
}

function subscribe(client) {
  const subscription = `
    subscription CountChanged {
      countChanged
    }
    `;

    // Send the subscription. You can also pass, eg, `variables`, as an option.
  client.subscribe({query: subscription}, ({ subscriptionId, result }) => {
    // console.log(`Subscription Data [ID:${subscriptionId}]`, result);
    const count = result.data.countChanged;
    store.commit('countChanged', { count });
  })
    // Log that you've subscribed, if you want to.
    .then(({ subscriptionId }) => {
      console.log(`Subscription Created [ID:${subscriptionId}]`);
    })
    // Do something with validation errors, etc.
    .catch(resp => console.error(`Subscription Failed`, resp));
}

function incrementCountBy({ token, by }) {
  const options = {
    headers: { Authorization: token }
  };
  const query = `mutation IncrementCountBy($by: Int) {
    incrementCountBy(by: $by)
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
