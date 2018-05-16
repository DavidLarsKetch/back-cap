<template>
  <div id='stuk'>
    <nav>
      <user-picker
        @userselected="updateUser($event)"
      />
      <device-picker
        :user-id="userId"
        @deviceselected="updateDevice($event)"
      />
      <schedule-picker
        :device-id="deviceId"
        @scheduleselected="updateSchedule($event)"
        />
    </nav>
    <stats
      :schedule-id="scheduleId"
    />
    <graph
      :schedule-id="scheduleId"
    />
  </div>
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
