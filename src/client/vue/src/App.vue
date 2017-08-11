<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import 'bootstrap/dist/css/bootstrap.min.css';
export default {
  name: 'app'
};
</script>

<style lang="scss">
*,
*::before,
*::after {
  box-sizing: border-box;
}

html, body, #app {
  font-size: 100%;
  height: 100%;
}

</style>
