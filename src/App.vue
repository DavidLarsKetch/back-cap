<template lang='pug'>
  div#stuk.stuk
    h2.stuk__error(v-if="errorMessage") {{ errorMessage }}
    nav
      user-picker(
        @userselected='updateUser($event)'
        @error='errorHandler($event)'
      )
      device-picker(
        :user-id="userId"
        @deviceselected="updateDevice($event)"
        @error='errorHandler($event)'
      )
      schedule-picker(
        :device-id='deviceId'
        @scheduleselected='updateSchedule($event)'
        @newscheduleselected='newScheduleSelected'
        @error='errorHandler($event)'
      )
      h1.stuk__title stuk
    div.stuk__cards
      new-schedule-form.stuk__card(
        :device-id='deviceId'
        v-if='makeNew === true'
      )
      schedule-info.stuk__card(
        :schedule-info='scheduleInfo'
      )
      stats.stuk__card(
        @error='errorHandler($event)'
        :schedule-id='scheduleId'
      )
      graph.stuk__card(
        @error='errorHandler($event)'
        :schedule-info='scheduleInfo'
      )
</template>

<script>
import stats from './components/stats.vue'
import graph from './components/graph.vue'
import schedulePicker from './components/schedulePicker.vue'
import userPicker from './components/userPicker.vue'
import devicePicker from './components/devicePicker.vue'

export default {
  name: 'stuk',
  components: {
    schedulePicker,
    userPicker,
    devicePicker,
    stats,
    graph,
  },
  data () {
    return {
      userId: null,
      deviceId: null,
      scheduleId: null
    }
  },
  methods: {
    updateUser (id) {
      this.userId = id
    },
    updateDevice (id) {
      this.deviceId = id
    },
    updateSchedule (id) {
      this.scheduleId = id
    }
  }
}
</script>

<style>
#stuk {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
