<template lang="html">
  <span class="schedule">
    <h4>{{ title }}</h4>
    <h3>{{ errorMsg }}</h3>
    <div v-if="schedules" class="schedule__btn-wrapper">
      <button class="schedule__dropdown-button" @click="scheduleSelected(scheduleId)" :key="idx" v-for="(scheduleId, idx) in schedules">
        {{ scheduleId }}
      </button>
    </div>
  </span>
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

export default {
  name: "schedulePicker",
  data () {
    return {
      errorMsg: null,
      title: 'Please pick a device first',
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule',
      schedules: null
    }
  },
  props: ['deviceId'],
  watch: {
    deviceId (id) {
      this.$emit('scheduleselected', null)
      this.title = 'Pick your device\'s schedule'
      this.getDevicesSchedule(id)
    }
  },
  methods: {
    scheduleSelected (id) {
      this.$emit('scheduleselected', id)
    },
    getDevicesSchedule (id) {
      const vm = this
      vm.scheduleId = null

      axios.get(`${vm.url}?DeviceId=${id}`)
      .then(({status, data: {body: { Items } } }) => {
        if (status !== 200) return vm.errorMsg = 'Schedules not found!'
        vm.schedules = Items.map(i => i.ScheduleId)
      })
      .catch(err => {
        vm.errorMsg = `Here's your schedule error: ${err}!`
      })
    }
  }
}
</script>

<style lang="css">
</style>
