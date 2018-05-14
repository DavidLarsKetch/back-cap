<template>
  <div class="temp">
    <h4 v-if="msg">{{ msg }}</h4>
    <div>
      <h2 v-if="temp">Current: {{ temp }} &#176; F</h2>
      <span v-if="timeLast">Taken at: <b>{{ timeLast }}</b></span>
    </div>
    <h3 v-if="avg">Average: {{ avg }} &#176; F</h3>
    <div>
      <h3 v-if="tempMax">Highest: {{ tempMax }} &#176; F</h3>
      <span v-if="timeMax">Taken at: <b>{{ timeMax }}</b></span>
    </div>
    <div>
      <h3 v-if="tempMin">Lowest: {{ tempMin }} &#176; F</h3>
      <span v-if="timeMin">Taken at: <b>{{ timeMin }}</b></span>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']
import moment from 'moment'

export default {
  name: 'stats',
  data: function () {
    return {
      temp: null,
      timeLast: null,
      avg: null,
      tempMax: null,
      timeMax: null,
      tempMin: null,
      timeMin: null,
      msg: '',
      urlStatTable: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//stat?ScheduleId=s2620215963'
    }
  },
  created: function () {
// NOTE: Switch these out for updating every .5 seconds
    this.getStatsForSchedule(this.urlStatTable);
    // this.recursivceApiCall();
  },
  methods: {
    getStatsForSchedule: function (url) {
      const vm = this;
      axios.get(url)
      .then(({status, data: {body: {Items}}}) => {
// TODO: Remove console.log
        console.log("Called the API to get data for stats!");
        if (status !== 200) return vm.msg = 'Not Found!';
// TODO: Destructure
        const stats = Items[0];

        vm.avg = stats.TempAvg;
        vm.temp = stats.LastTemp;
        vm.timeLast = moment(`${stats.Stamp}-05:00`).format('MMM Do, h:mm:ss a');
        vm.tempMax = stats.TempMax;
        vm.timeMax = moment(`${stats.TimestampMax}-05:00`).format('MMM Do, h:mm:ss a');
        vm.tempMin = stats.TempMin;
        vm.timeMin = moment(`${stats.TimestampMin}-05:00`).format('MMM Do, h:mm:ss a');
      })
      .catch((error) => {
        vm.msg = `Here's your stats error: ${error}`
      });
    },
    // recursivceApiCall () {
    //   const vm = this;
    //   vm.getStatsForSchedule(vm.urlStatTable);
    //   setTimeout(function run() {
    //     vm.getStatsForSchedule(vm.urlStatTable);
    //     vm.msg = '';
    //     setTimeout(run, 500);
    //   }, 500);
    // }
  },
  props: {
    foo: 'bar'
  }
}
</script>

<style scoped>

</style>
