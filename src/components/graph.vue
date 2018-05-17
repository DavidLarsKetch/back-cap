<template lang='pug'>
  div.graph(v-if='collection')
    line-graph(:chart-data='collection')
</template>

<script>
import lineGraph from './lineGraph.js'
import { formatLineGraphData } from './lineGraphDataExtraction.js'

import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

export default {
  name: 'graph',
  components: {
    lineGraph
  },
  props: ['scheduleId'],
  data () {
    return {
      errorMsg: '',
      collection: null,
      selectedId: this.scheduleId,
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data'
    }
  },
  watch: {
    scheduleId () {
      const vm = this
      this.selectedId = this.scheduleId
      this.collection = null
      this.getGraphDataForSchedule()
      this.recursivceApiCall()
    }
  },
  methods: {
    getGraphDataForSchedule () {
      const vm = this;
// TODO: Get Fetch to work with Access-Control-Allow-Origin header
      axios.get(`${vm.url}?ScheduleId=${vm.selectedId}`)
      .then(({ status, data: { body } }) => {
        if (status !== 200 || body.errorMessage) return vm.errorMsg = 'Not Found!'

        vm.collection = formatLineGraphData(body.Items)
      })
      .catch(function(error) {
        vm.errorMsg = `Here's your graph error: ${error}`
      });
    },
    recursivceApiCall () {
      const vm = this
      setTimeout(function run() {
        vm.getGraphDataForSchedule(vm.selectedId)
        vm.errorMsg = ''
        setTimeout(run, 1000)
      }, 1000)
    }
  }
}
</script>

<style scoped>
  .graph {
    margin: 0 auto;
    max-width: 75vw;
  }
</style>
