<template>
  <div class="temp">
    <h4>{{ errorMsg }}</h4>
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
import moment from 'moment'

import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

import { extractStatsData } from './statsDataExtraction'

export default {
  name: 'stats',
  props: ['scheduleId'],
  watch: {
    scheduleId () {
      this.selectedId = this.scheduleId

      this.getStatsForSchedule()
      this.recursivceApiCall()
    }
  },
  data () {
    return {
      selectedId: this.scheduleId,
      temp: null,
      timeLast: null,
      avg: null,
      tempMax: null,
      timeMax: null,
      tempMin: null,
      timeMin: null,
      errorMsg: null,
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//stat'
    }
  },
  methods: {
    getStatsForSchedule () {
      const vm = this
      axios.get(`${vm.url}?ScheduleId=${this.selectedId}`)
      .then(({status, data: { body } }) => {
        if (status !== 200 || body.errorMessage) return vm.msg = 'Not Found!'
        const stats = body.Items[0]
        vm.avg = stats.TempAvg
        vm.temp = stats.LastTemp
        vm.timeLast = moment(`${stats.Stamp}-05:00`).format('MMM Do, h:mm:ss a')
        vm.tempMax = stats.TempMax
        vm.timeMax = moment(`${stats.TimestampMax}-05:00`).format('MMM Do, h:mm:ss a')
        vm.tempMin = stats.TempMin
        vm.timeMin = moment(`${stats.TimestampMin}-05:00`).format('MMM Do, h:mm:ss a')
      })
      .catch((error) => {
        vm.msg = `Here's your stats error: ${error}`
      })
    },
    recursivceApiCall () {
      const vm = this
      setTimeout(function run() {
        vm.getStatsForSchedule(this.selectedId)
        vm.msg = ''
        setTimeout(run, 1000)
      }, 1000)
    }
  }
}
</script>

<style scoped>

</style>
