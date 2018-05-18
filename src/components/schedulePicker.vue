<template lang='pug'>
  .schedule
    h4.schedule__title {{ title }}
    .schedule__wrapper-btn(v-if='deviceId')
      button.schedule__btn(
        v-for="(schedule, idx) in schedules"
        :key='idx'
        :class='{"-selected": selectedSchedule === schedule.ScheduleId}'
        @click="scheduleSelected(schedule)"
      ) {{ schedule.ScheduleId }}
      button.schedule__btn.-new(
        v-if='newScheduleAvailable'
        @click="newScheduleSelected(true)"
      ) New Schedule
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

export default {
  name: "schedulePicker",
  data() {
    return {
      selectedDevice: this.deviceId,
      selectedSchedule: null,
      title: 'Please pick a device first',
      newScheduleAvailable: null,
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule',
      schedules: null
    }
  },
  props: ['deviceId', 'makeNew'],
  watch: {
    deviceId() {
      this.selectedDevice = this.deviceId
      this.$emit('scheduleselected', null)
      this.title = 'Pick your device\'s schedule'
      this.getDevicesSchedule()
      this.recursivceApiCall()
    },
    makeNew() {
      this.newScheduleAvailable = this.makeNew
      if (this.newScheduleAvailable === false) {
        this.getDevicesSchedule()
        this.recursivceApiCall()
      }
    }
  },
  methods: {
    scheduleSelected(obj) {
      this.selectedSchedule = obj.ScheduleId
      this.$emit('scheduleselected', obj)
    },
    newScheduleSelected() {
      this.selectedSchedule = null
      this.$emit('newscheduleselected', true)
    },
    getDevicesSchedule() {
      const vm = this
      if (vm.selectedDevice === null) return vm.schedules = null

      axios.get(`${vm.url}?DeviceId=${vm.selectedDevice}`)
      .then(({status, data: {body: { Items } } }) => {
        if (status !== 200) return vm.$emit('error', 'Schedules not found!')
        if (Items.length === 0) return

        vm.schedules = Items.filter(i => i.StartDate)

        const emptySchedules = Items.filter(i => !i.StartDate)
        if (emptySchedules.length > 0) {
          vm.newScheduleAvailable = true
          vm.$emit('emptyschedules', emptySchedules)
        }
      })
      .catch(err => {
        vm.$emit('error', `Schedule - ${err}!`)
      })
    },
    recursivceApiCall () {
      const vm = this
      setTimeout(function run() {
        vm.getDevicesSchedule(vm.selectedId)
        vm.msg = ''
        setTimeout(run, 2000)
      }, 2000)
    }
  }
}
</script>

<style lang="scss">
  .schedule {
    &__btn {
      background-color: silver;
      border: 3px solid black;
      border-bottom: 0;
      font-family: monospace;
      margin: 0 .075rem;
      padding: .5rem;
    }
    &__title {
      text-decoration: underline;
    }
  }
  .-selected {
    background-color: aliceblue;
  }
  .-new {
    background-color: lightgreen;
  }
</style>
