<template lang="pug">
  span.user
    h4.user__title {{ title }}
    select.user__dropdown(@change='userSelected' v-model='userId')
      option.user__dropdown-option(
        v-for='(user, idx) in users'
        :key='idx'
      ) {{ user.UserId }}
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

export default {
  name: "userPicker",
  data() {
    return {
      title: 'Pick a user:',
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//user',
      userId: null,
      users: null
    }
  },
  created() {
    this.getAllUsers()
  },
  methods: {
    userSelected() {
      this.$emit('userselected', this.userId)
    },
    getAllUsers() {
      const vm = this

      axios.get(vm.url)
      .then(({ status, data: { body: { Items } } }) => {
        if (status !== 200) return vm.$emit('error', 'Users not found!')
        vm.users = Items
      })
      .catch(err => {
        vm.$emit('error', `User - ${err}`)
      })
    }
  }
}
</script>

<style lang="scss">
  .user {
    &__dropdown {
      font-family: monospace;
      margin-bottom: .95rem;
      min-width: 10vw;
    }
    &__title {
      text-decoration: underline;
    }
  }
</style>
