<template>
  <div id="app">
    <!-- <img src="./assets/logo.png"> -->
    <temp/>
  </div>
</template>

<script>
import temp from './components/temp.vue'

export default {
  name: 'app',
  components: {
    temp
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
