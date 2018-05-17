<template lang="pug">
  div.stats(v-if='scheduleId')
    div.stats__wrapper.-current(v-if='temp')
      h2.stats__current Current: {{ temp }} &#176; F
      .stats__time {{ timeLast }}
    div.stats__wrapper.-avg(v-if='avg')
      h2.stats__avg Average: {{ avg }} &#176; F
    div.stats__wrapper.-highest(v-if='tempMax')
      h3.stats__highest Highest: {{ tempMax }} &#176; F
      .stats__time {{ timeMax }}
    div.stats__wrapper.-lowest(v-if='tempMin')
      h3.stats__lowest Lowest: {{ tempMin }} &#176; F
      .stats__time {{ timeMin }}
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

<style scoped lang='scss'>
  .stats {
    display: grid;
    grid: repeat(4, auto) / auto;
    padding: 2rem;

    &__wrapper {
      border: 3px solid black;
      margin: 1rem auto;
      padding: 0 3rem;
    }
    &__time {
      margin-bottom: 1rem;
    }
    .-avg {
      background-color: lightgreen;
    }
    .-current {
      background-color: lemonchiffon;
    }
    .-highest {
      background-color: lightsalmon;
    }
    .-lowest {
      background-color: lightblue;
    }
  }
</style>
