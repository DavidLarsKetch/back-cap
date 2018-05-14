<template>
  <div class="graph">
    <h4 v-if="msg">{{ msg }}</h4>
    <line-graph :chart-data="data"/>
  </div>
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
  data () {
    return {
      msg: '',
      data: null,
      urlDataTable: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data?ScheduleId=s2620215963'
    }
  },
  created () {
// NOTE: Switch these out for updating every .5 seconds
    this.getGraphDataForSchedule(this.urlDataTable);
    // this.recursivceApiCall();
  },
  methods: {
    getGraphDataForSchedule (url) {
      const vm = this;
// TODO: Get Fetch to work with Access-Control-Allow-Origin header
      axios(url)
      .then(({status, data: {body: {Items}}}) => {
// TODO: Remove console.log
        console.log('Called the API to get data for graphs');

        if (status !== 200) return vm.msg = 'Not Found!';

        vm.data = formatLineGraphData(Items)
      })
      .catch(function(error) {
        vm.msg = `Here's your graph error: ${error}`;
      });
    }
  }
}
</script>

<style scoped>

</style>
