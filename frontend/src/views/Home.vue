<template>
  <div id="app">
    <landing v-if="! userSession.isUserSignedIn()"></landing>
    <userinfo v-if="user" :user="user"></userinfo>
    <rawdata v-if="user" :user="user"></rawdata>
    <!-- <diagram v-if="user" :user="user"></diagram> -->

    <small class="creds">
      Source code on <a href="https://github.com/tyGavinZJU/Gaia-Provider" target="_blank">Github</a>
    </small>
  </div>
</template>

<script>
import Landing from '@/components/Landing.vue'
import Userinfo from '@/components/Userinfo.vue'
import Rawdata from '@/components/Rawdata.vue'
import Diagram from '@/components/Diagram.vue'
import { Person } from 'blockstack'
import { userSession } from '../userSession'

export default {
  name: 'Home',
  components: { Landing, Userinfo, Rawdata, Diagram },
  created () {
    this.userSession = userSession
  },
  mounted () {
    if (userSession.isUserSignedIn()) {
      this.userData = userSession.loadUserData()
      this.user = new Person(this.userData.profile)
      this.user.username = this.userData.username
    } else if (userSession.isSignInPending()) {
      userSession.handlePendingSignIn()
        .then((userData) => {
          window.location = window.location.origin
        })
    }
  },
  data () {
    return {
      userSession: null,
      user: null
    }
  }
}
</script>
<style scoped>
.app {
            display:flex;
            flex-direction:column;
            justify-content: center;
            height:100%;
            overflow:auto;
            background-color: rgb(20,18,19)
      }

</style>
