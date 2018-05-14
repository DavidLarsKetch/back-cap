<template>
  <div id='stuk'>
    <stats/>
    <graph/>
  </div>
</template>

<script>
import stats from './components/stats.vue'
import graph from './components/graph.vue'

export default {
  name: 'stuk',
  components: {
    stats,
    graph,
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
