<template lang='pug'>
  span.schedule
    h4.schedule__title {{ title }}
    div.schedule__wrapper-btn(v-if='schedules')
      button.schedule__btn(
        v-for="(schedule, idx) in schedules"
        :key='idx'
        :class='{"-selected": selectedSchedule === schedule.ScheduleId}'
        @click="scheduleSelected(schedule)"
      ) {{ schedule.ScheduleId }}
      button.schedule__btn.-new(
        @click="newScheduleSelected"
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
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule',
      schedules: null
    }
  },
  props: ['deviceId'],
  watch: {
    deviceId() {
      this.selectedDevice = this.deviceId
      this.$emit('scheduleselected', null)
      this.title = 'Pick your device\'s schedule'
      this.getDevicesSchedule(this.selectedDevice)
    }
  },
  methods: {
    scheduleSelected(obj) {
      this.selectedSchedule = obj.ScheduleId
      this.$emit('scheduleselected', obj)
    },
    newScheduleSelected() {
      this.selectedSchedule = null
      this.$emit('newscheduleselected')
    },
    getDevicesSchedule() {
      const vm = this
      if (vm.selectedDevice === null) return vm.schedules = null

      axios.get(`${vm.url}?DeviceId=${vm.selectedDevice}`)
      .then(({status, data: {body: { Items } } }) => {
        if (status !== 200) return vm.$emit('error', 'Schedules not found!')
        if (Items.length === 0) return
        vm.schedules = Items
      })
      .catch(err => {
        vm.$emit('error', `Schedule - ${err}!`)
      })
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
