<template lang="pug">
  .new-schedule-form
    p New Schedule
    form.new-schedule-form__form
      span Start &amp; End:
      br
      input.new-schedule-form__start.new-schedule-form__input(
        type='datetime-local'
        v-model='start'
      )
      input.new-schedule-form__end.new-schedule-form__input(
        type='datetime-local'
        v-model='end'
      )
      span Temperature Range:
      br
      input.new-schedule-form__max.new-schedule-form__input(
        type='integer'
        placeholder='Max Target Temp ( F )'
        default='80'
        v-model='max'
      )
      input.new-schedule-form__min.new-schedule-form__input(
        type='integer'
        placeholder='Min Target Temp ( F )'
        default='60'
        v-model='min'
      )
      div
        span Type:
        br
        select.new-schedule-form__input.new-schedule-form__type(
          v-model='type'
        )
          option(
            v-for='ferment in ferments'
            :value='ferment'
          ) {{ ferment }}
    .new-schedule-form__results-wrapper
      h4 Start Date:&nbsp;
        span {{ readableStart }}
      h4 End Date:&nbsp;
        span {{ readableEnd }}
      h4 Max Target Temp:&nbsp;
        span.new-schedule-form__output-max {{ max }} &#176; F
      h4 Min Target Temp:&nbsp;
        span.new-schedule-form__output-min {{ min }} &#176; F
      h4 Fermentation Type: {{ type }}
    .new-schedule-form__wrapper-btn
      button.new-schedule-form__btn(
        @click='postNewSchedule'
      ) Submit
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

import moment from 'moment'

export default {
  name: "newScheduleForm",
  props: ['deviceId'],
  data() {
    return {
      end: null,
      ferments: ['Beer', 'Kombucha', 'Tempeh', 'Yogurt', 'Koji', 'Wine', 'Whiskey', 'Cheese', 'Vodka', 'Sake'],
      max: null,
      min: null,
      start: null,
      type: null,
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule'
    }
  },
  computed: {
    readableEnd() {
      if (!this.end) return null
      return moment(this.end).format('MMM Do, h:mm:ss a')
    },
    readableStart() {
      if (!this.start) return null
      return moment(this.start).format('MMM Do, h:mm:ss a')
    }
  },
  methods: {
    postNewSchedule() {
      const vm = this
      console.log(vm.deviceId);
      const scheduleId =
        `s${vm.randomInt(99999999)}`.padEnd(9, vm.randomInt(10))
      if (!vm.start || !vm.end || !vm.type || !vm.max || !vm.min) return
      const body = {
        DeviceId: vm.deviceId,
        ScheduleId: scheduleId,
        StartDate: vm.start,
        EndDate: vm.end,
        FermentType: vm.type,
        TargetMax: vm.max,
        TargetMin: vm.min
      }

      axios.post(vm.url, {Item: body})
      .then(resp => {
// TODO: Emit the proper event to get to the standard view
        this.$emit('scheduleselected', scheduleId)
      })

    },
    randomInt(max) {
      return Math.floor(Math.random() * Math.floor(max))
    }
  }
}
</script>

<style lang="scss">
  .new-schedule-form {
    padding: 2rem;

    &__btn {
      background-color: lightgreen;
      border: 3px solid black;
      font-size: 2rem;
      padding: .33rem 1.33rem;
    }
    &__form {
      font-family: monospace;
      font-size: 1rem;
      text-align: left;
    }
    &__input {
      margin: .5rem 1rem;
    }
    &__output-max {
      color: lightsalmon;
    }
    &__output-min {
      color: lightblue;
    }
    &__results-wrapper {
      text-align: right;
    }
  }
</style>
