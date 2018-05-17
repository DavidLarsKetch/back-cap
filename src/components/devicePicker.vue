<template lang="pug">
  span.device
    h4.device__title {{ title }}
    div.device__btns-wrapper(v-if='devices')
      button.device__btn(
        v-for='(deviceId, idx) in devices'
        :key='idx'
        :class='{"-selected": selectedDevice === deviceId}'
        @click='deviceSelected(deviceId)'
      ) {{ deviceId }}
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

export default {
  name: "devicePicker",
  props: ['userId'],
  watch: {
    userId (id) {
      this.$emit('deviceselected', null)
      this.title = 'Pick a device:'
      this.getUsersDevices(id)
    }
  },
  data () {
    return {
      title: 'Please pick a user first',
      errorMsg: '',
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//device',
      devices: null
    }
  },
  methods: {
    deviceSelected (id) {
      this.$emit('deviceselected', id)
      },
    getUsersDevices (id) {
      const vm = this
      vm.deviceId = null

      axios.get(`${vm.url}?UserId=${id}`)
      .then(({ status, data: { body: { Items } } }) => {
        if (status !== 200) return vm.errorMsg = 'Devices not found!'
        vm.devices = Items.map(i => i.DeviceId)
      })
      .catch(err => {
        vm.errorMsg = `Here's your device error: ${err}!`
      })
    }
  }

}
</script>

<style lang="scss">
  .device {
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
</style>
