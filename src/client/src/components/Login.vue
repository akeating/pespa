<template>
  <div class="login-container">
    <div class="form-container">
      <form class="login-form" v-on:submit.prevent="submit">
        <input class="form-control"
          type="email"
          v-model="email"
          placeholder="email">
        <input class="form-control"
          type="password"
          v-model="password"
          placeholder="password">
        <div>
          <button class="btn btn-primary login-button"
            type="submit"
            v-bind:disabled="!formValid">
            login
          </button>
          <label class="trust-option">
            <input type="checkbox" v-model="trust"> Trust this computer
          </label>
        </div>
      </form>
      <label class="error-label" v-show="showError">Unable to login</label>
    </div>
  </div>
</template>

<script>
import api from '../api';
import store from '../store';
import router from '../router';

export default {
  name: 'login',
  data: function() {
    const trust = api.localStorage.getTrust();
    return {
      email: 'demo@example.com',
      password: 'foo',
      trust,
      showError: false
    };
  },
  computed: {
    formValid() {
      return !!this.email && !!this.password;
    }
  },
  methods: {
    submit() {
      const options = {
        email: this.email,
        password: this.password
      };
      this.showError = false;
      return store.dispatch('exchangeCredentialsForToken', options).then((token) => {
        return store.dispatch('whoami', { token }).then((user) => {
          if (this.trust) {
            api.localStorage.setTrust(true);
            api.localStorage.setToken(token);
          } else {
            api.localStorage.setTrust(false);
            api.localStorage.clearToken();
          }
          router.push({ name: 'dashboard' });
        });
      }).catch(_err => {
        this.showError = true;
      });
    }
  }
};
</script>

<style lang="scss" scoped>
.login-container {
  .form-container {
    margin: 60px auto 0px auto;
    width: 400px;
    form {
      background-color: #EEE;
      padding: 10px;
      display: flex;
      flex-direction: column;
      input {
        margin-bottom: 10px;
      }
      .trust-option {
        margin: 0 0 0 10px;
      }
    }
    .error-label {
      color: red;
    }
  }
}
</style>
