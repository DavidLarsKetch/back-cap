<template lang='pug'>
  .schedule-info(v-if='scheduleInfo')
    h2.schedule-info__current-time {{ currentTime }}
    .schedule-info__wrapper
      .schedule-info__wrapper-time
        .schedule-info__start(v-if='startDate')
          p
            i Start:
            br
            b {{ startDate }}
        .schedule-info__complete(v-if='timeToComplete')
          p
            i Time until done:
            br
            b {{ timeToComplete }}
        .schedule-info__end(v-if='endDate')
          p
            i End:
            br
            b {{ endDate }}

      .schedule-info__wrapper-temp(v-if='max')
        h3.schedule-info__temp-title Target
        .schedule-info__type(
          v-if='type'
          :class='type'
        )
          b {{ type.slice(0,1).toUpperCase() + type.slice(1) }}
        .schedule-info__nums.schedule-info__max {{ max }} &#176; F
        .schedule-info__nums.schedule-info__min {{ min }} &#176; F
</template>

<script>
import moment from 'moment'
require('moment-countdown')

export default {
  name: "schedule-info",
  props: ['scheduleInfo'],
  data () {
    return {
      currentTime: null,
      startDate: null,
      timeToComplete: null,
      endDate: null,
      type: null,
      max: null,
      min: null
    }
  },
  created () {
    this.currentTime = moment().format('LTS')
    setInterval(() => this.getTime(), 1000)
  },
  watch: {
//QUESTION: Does this need to be 'watch' or can it be 'computed'?
    scheduleInfo () {
      const vm = this
      vm.extractScheduleInfo(vm.scheduleInfo)
    }
  },
  methods: {
    extractScheduleInfo (schedule) {
      const vm = this
      if (!schedule) {
        vm.startDate = null, vm.timeToComplete = null, vm.endDate = null,
        vm.type = null, vm.max = null, vm.min = null
        return
      }

      const {
        StartDate, EndDate, FermentType, TargetMax, TargetMin
      } = schedule

      const start = new moment(`${StartDate}-05:00`)
      vm.endMoment = new moment(`${EndDate}-05:00`)
      vm.startDate = start.format('MMM Do, h:mm:ss a')
      vm.endDate = vm.endMoment.format('MMM Do, h:mm:ss a')
      vm.type = FermentType
      vm.timeToComplete = moment(vm.endMoment).countdown().toString()
      vm.max = TargetMax
      vm.min = TargetMin
    },
    getTime () {
      this.currentTime = moment().format('LTS')

      if (this.timeToComplete) {
        this.timeToComplete = moment(this.endMoment).countdown().toString()
      }
    }
  }
}
</script>

<style lang="scss">
  .schedule-info {
    display: grid;
    grid: auto 1fr / auto;
    padding: 2rem;

    &__complete {

    }
    &__current-time {
      margin-top: 0;
    }
    &__end {

    }
    &__start {

    }
    &__temp-title {
      border-bottom: 2px solid black;
      margin: 0 auto 1rem auto;
      padding: 0 1rem;
    }
    &__type {
      color: white;
      font-size: 2rem;
      margin: auto;
      padding: 2rem .55rem;
    }
    &__wrapper {
      display: grid;
      grid: auto / repeat(2, 1fr);
    }
    &__wrapper-temp {
      display: grid;
      grid: auto repeat(3, 1fr) / auto;
    }
    &__wrapper-time {
      display: grid;
      grid: repeat(3, 1fr) / auto;
    }
    &__nums {
      color: white;
      font-size: 3rem;
      font-weight: bold;
      margin: auto;
      padding: 1.5rem 1.5rem;
    }
    &__max {
      background-color: lightsalmon;
    }
    &__min {
      background-color: lightblue;

    }
    .kombucha {
      background-color: khaki;
    }
    .yogurt {
      background-color: lightcyan;
      color: black;
    }
  }
</style>
