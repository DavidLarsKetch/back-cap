<template lang="html">
  <span class="device">
    <h4>{{ title }}</h4>
    <h3>{{ errorMsg }}</h3>
    <div class="device__btns-wrapper" v-if="devices">
      <button class="device__button" @click="deviceSelected(deviceId)" :key="idx" v-for="(deviceId, idx) in devices">
        {{ deviceId }}
      </button>
    </div>
  </span>
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

<style lang="css">
</style>
