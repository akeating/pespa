<template>
  <div class="dashboard">
    <h2>dashboard content</h2>
    <div class="count-container" v-if="hasCount">
      <button @click="decrementCount()">-</button>
      <span>{{count}}</span>
      <button @click="incrementCount()">+</button>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: 'dashboard',
  computed: {
    ...mapState(['count']),
    hasCount: function() {
      return !isNaN(this.count);
    }
  },
  methods: {
    incrementCount() {
      this.$store.dispatch('incrementCountBy', { by: 1 });
    },
    decrementCount() {
      this.$store.dispatch('incrementCountBy', { by: -1 });
    }

  },
  created: function() {
    this.$store.dispatch('incrementCountBy', { by: 0 });
  }
};
</script>

<style lang="scss" scoped>
  .dashboard {
    margin: 15px;
    > div {
      width: 200px;
      text-align: center;
      margin: 60px auto 0 auto;
    }
  }
</style>
