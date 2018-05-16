<template lang="html">
  <span class="user">
    <h4>{{ title }}</h4>
    <h3>{{ errorMsg }}</h3>
    <select class="user__dropdown" @change="userSelected" v-model="userId">
      <option class="user__dropdown-option" :key="idx" v-for="(user, idx) in users">
        {{ user.UserId }}
      </option>
    </select>
  </span>
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common['Access-Control-Allow-Origin']

export default {
  name: "userPicker",
  data () {
    return {
      title: 'Pick a user:',
      errorMsg: '',
      url: 'https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//user',
      userId: null,
      users: null
    }
  },
  created () {
    this.getAllUsers()
  },
  methods: {
    userSelected () {
      this.$emit('userselected', this.userId)
    },
    getAllUsers () {
      const vm = this

      axios.get(vm.url)
      .then(({ status, data: { body: { Items } } }) => {
        if (status !== 200) return vm.errorMsg = 'Users not found!'
        vm.users = Items
      })
      .catch(err => {
        vm.errorMsg = `This is your User error message: ${err}`
      })
    }
  }
}
</script>

<style lang="css">
</style>
