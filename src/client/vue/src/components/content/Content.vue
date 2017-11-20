<template>
  <div class="content">
    <div class="content-header">
      <h3 routerLink="/">Demo</h3>
      <div class="scratch">
        <span v-bind:class="{ connected: connected }">{{connected ? 'Online' : 'Offline'}}</span>
      </div>
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
    ...mapState(['connected']),
    ...mapState({
      name: (state) => {
        return state.currentUser && state.currentUser.name;
      },
      email: (state) => {
        return state.currentUser && state.currentUser.email;
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
    this.$store.dispatch('connect').then((connection) => {
      this.$store.dispatch('subscribeToCountChanged');
      // connection.onReconnect = () => {
      //   this.$store.dispatch('subscribeToCountChanged');
      // };
    });
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
    .scratch {
      flex: 1;
      text-align: center;
      > span {
        padding: 3px 5px;
        color: white;
        background-color: red;
        &.connected {
          background-color: green;
        }
      }
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
