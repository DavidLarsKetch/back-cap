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
import debounce from 'lodash.debounce';
import axios from 'axios';
axios.defaults.headers.common['Access-Control-Allow-Origin'];
import moment from 'moment';

export default {
  name: 'temp',
  data: function () {
    return {
      temp: null,
      timeLast: null,
      avg: null,
      tempMax: null,
      timeMax: null,
      tempMin: null,
      timeMin: null,
      msg: ''
    }
  },
  created: function () {
    this.getScheduleData();
  },
  methods: {
    getScheduleData: function () {
      const vm = this;
      const apiCall = () => axios.get('https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data?ScheduleId=s2620215963')
      .then(function(allData) {
        console.log("Called the API!");
        if (allData.status !== 200) return vm.msg = 'Not Found!';
        axios.get('https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//stat?ScheduleId=s2620215963')
        .then(function(statData) {
          if (statData.status !== 200) return vm.msg = 'Not Found!';

          allData = allData.data.body.Items;
          statData = statData.data.body.Items[0];

          vm.avg = statData.TempAvg;
          vm.temp = statData.LastTemp;
          vm.timeLast = moment(`${statData.Stamp}-05:00`).format('MMM Do, h:mm:ss a');
          vm.tempMax = statData.TempMax;
          vm.timeMax = moment(`${statData.TimestampMax}-05:00`).format('MMM Do, h:mm:ss a');
          vm.tempMin = statData.TempMin;
          vm.timeMin = moment(`${statData.TimestampMin}-05:00`).format('MMM Do, h:mm:ss a');
        })
        .catch(function(error) {
          vm.msg = `Here's your error: ${error}`
        });
      })
      .catch(function(error) {
        vm.msg = `Here's your error: ${error}`;
      });

      apiCall();
      setTimeout(function run() {
        apiCall();
        vm.msg = '';
        setTimeout(run, 1000);
      }, 1000);
    }
  },
  props: {
    // isDisabled: Boolean,
    foo: String
  }
}
</script>

<style scoped>

</style>
