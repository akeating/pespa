<template>
  <div class="dashboard">
    <div>dashboard content</div>
  </div>
</template>

<script>
export default {
  name: 'dashboard',
  computed: {}
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
