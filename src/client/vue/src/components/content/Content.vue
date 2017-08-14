<template>
  <div class="content">
    <div class="content-header">
      <h3 routerLink="/">Demo</h3>
      <span>{{online}}</span>
      <div class="controls">
        <div>Welcome, {{name}} ({{email}})</div>
        <button class="btn btn-link" v-on:click="logout">Logout</button>
      </div>
    </div>
    <div class="content-body">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: 'container',
  computed: {
    ...mapState({
      name: (state) => {
        return state.currentUser && state.currentUser.name;
      },
      email: (state) => {
        return state.currentUser && state.currentUser.email;
      },
      online: (state) => {
        return state.online ? 'Online' : 'Offline';
      }
    })
  },
  methods: {
    logout() {
      this.$store.dispatch('logout').then(() => {
        this.$router.push({ name: 'login' });
      });
    }
  },

  created: function() {
    // Creates websocket and subscriptions
    this.$store.dispatch('connect');
  }
};
</script>

<style lang="scss" scoped>
.content {
  display: flex;
  flex-direction: column;
  height: 100%;

  .content-header {
    display: flex;
    align-items: center;
    background-color: #EEE;
    height: 50px;
    > h3 {
      margin: 0 15px;
      cursor: pointer;
    }
    > span {
    }
    .controls {
      margin-left: auto;
      display: flex;
      align-items: center;
    }
  }

  .content-body {
    flex: 1;
  }
}
</style>
