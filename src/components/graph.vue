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
  props: ['scheduleInfo'],
  data () {
    return {
      collection: null,
      type: null,
      selectedId: this.scheduleInfo ? this.scheduleInfo.ScheduleId : null,
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data'
    }
  },
  watch: {
    scheduleInfo () {
      const vm = this
      vm.selectedId = this.scheduleInfo ? this.scheduleInfo.ScheduleId : null
      vm.type = this.scheduleInfo ? this.scheduleInfo.FermentType : null
      vm.getGraphDataForSchedule()
      // vm.recursivceApiCall()
    }
  },
  methods: {
    getGraphDataForSchedule () {
      const vm = this;
      if (!vm.selectedId) return vm.collection = null
//TODO: Get Fetch to work with Access-Control-Allow-Origin header
      axios.get(`${vm.url}?ScheduleId=${vm.selectedId}`)
      .then(({ status, data: { body } }) => {
        if (status !== 200 || body.errorMessage) return vm.$emit('error', 'Not found!')

//TODO: Data decimation once body.Items is too large of a dataset
        vm.collection = formatLineGraphData(body.Items)
      })
      .catch(err => {
        vm.$emit('error', `Graph - ${err}`)
      });
    },
    recursivceApiCall () {
      const vm = this
      setTimeout(function run() {
        vm.getGraphDataForSchedule(vm.selectedId)
        setTimeout(run, 1000)
      }, 1000)
    }
  }
}
</script>

<style scoped lang='scss'>
  .graph {
    border: 1px dashed grey;
    padding: 0 2rem;
  }
</style>
