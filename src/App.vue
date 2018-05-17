<template lang='pug'>
  .stuk#stuk
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
    .stuk__cards
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
import scheduleInfo from './components/scheduleInfo.vue'
import schedulePicker from './components/schedulePicker.vue'
import userPicker from './components/userPicker.vue'
import devicePicker from './components/devicePicker.vue'
import newScheduleForm from './components/newScheduleForm.vue'

export default {
  name: 'stuk',
  components: {
    scheduleInfo,
    schedulePicker,
    newScheduleForm,
    userPicker,
    devicePicker,
    stats,
    graph,
  },
  data () {
    return {
      makeNew: false,
      userId: null,
      deviceId: null,
      scheduleId: null,
      scheduleInfo: null,
      errorMessage: null
    }
  },
  watch: {
    scheduleId () {
      if (this.scheduleId) {
        this.makeNew = false
      }
    }
  },
  methods: {
    updateUser (id) {
      this.userId = id
    },
    updateDevice (id) {
      this.deviceId = id
    },
    updateSchedule (schedule) {
      this.scheduleInfo = schedule ? schedule : null
      this.scheduleId = schedule ? schedule.ScheduleId : null
      this.makeNew = false
    },
    newScheduleSelected () {
      this.scheduleId = null
      this.scheduleInfo = null
      this.makeNew = true
    },
    errorHandler (err) {
      this.errorMessage = err
    }
  }
}
</script>

<style lang="scss">
.stuk {
  box-sizing: border-box;
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;

  button:focus {
    outline: 0;
  }

  nav {
    background-color: gainsboro;
    border: 3px solid black;
    display: grid;
    grid: auto / auto repeat(2, 1fr) auto;
    padding: 0 10vh;
  }

  &__error {
    color: red;
  }
  &__card {
    border: 1px dashed grey;
    font-size: 1.5rem;
    margin: 1vw .5vw;
  }
  &__cards {
    display: grid;
    grid: auto / repeat(3, 1fr);
  }
  &__title {
    font-family: monospace;
    font-size: 6rem;
    // background-color: dimgrey;
    color: dimgrey;
    margin: auto;
    // padding: 1rem;
  }
}
</style>
