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

export default {
  name: 'stats',
  props: ['scheduleId'],
  watch: {
    scheduleId () {
      const vm = this

      vm.selectedId = vm.scheduleId
      vm.getStatsForSchedule()
      // vm.recursivceApiCall()
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
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//stat'
    }
  },
  methods: {
    getStatsForSchedule () {
      const vm = this

      if (!vm.selectedId) return vm.resetStats()

      axios.get(`${vm.url}?ScheduleId=${vm.selectedId}`)
      .then(({status, data: { body } }) => {
        if (status !== 200 || body.errorMessage) return vm.$emit('error', 'Not Found!')
        if (!body.Item) return vm.resetStats()
        const stats = body.Item

//TODO: Still need to figure out a way to assign this to a vm.stats obj instead
//      of individual properties.
        vm.avg = vm.round(stats.TempAvg, 2)
        vm.temp = vm.round(stats.LastTemp, 4)
        vm.timeLast = moment(`${stats.Stamp}-05:00`).format('MMM Do, h:mm:ss a')
        vm.tempMax = vm.round(stats.TempMax, 2)
        vm.timeMax = moment(`${stats.TimestampMax}-05:00`).format('MMM Do, h:mm:ss a')
        vm.tempMin = vm.round(stats.TempMin, 2)
        vm.timeMin = moment(`${stats.TimestampMin}-05:00`).format('MMM Do, h:mm:ss a')
      })
      .catch((err) => {
        vm.$emit('error', `Stats - ${err}`)
      })
    },
    recursivceApiCall () {
      const vm = this
      setTimeout(function run() {
        vm.getStatsForSchedule(vm.selectedId)
        vm.msg = ''
        setTimeout(run, 1000)
      }, 1000)
    },
    round (n, p) {
      const factor = Math.pow(10, p)
      let rounded = Math.round(n * factor) / factor
      return rounded % 1 === 0 ? `${rounded}.00` : `${rounded}`.padEnd(5, '0')
    },
    resetStats() {
      const vm = this
      vm.temp = null, vm.timeLast = null, vm.avg = null, vm.tempMax = null,
      vm.tempMin = null, vm.timeMax = null, vm.timeMin = null
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
