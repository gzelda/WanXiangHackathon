<template>
  <div id="app">
    <landing v-if="! userSession.isUserSignedIn()"></landing>
    <div v-else-if="user">
      <userinfo :user="user"></userinfo>
      <CarRegister v-if="!isRegister" v-on:change_Register="changeRegister"></CarRegister>
      <SmartCarDashboard  v-else :user="user"></SmartCarDashboard>
    </div>
    <!-- <diagram v-if="user" :user="user"></diagram> -->
    <small class="creds">
      All rights reserved by <del>Don't</del> Can't be evil
      <br/>
      Source code on <a href="https://github.com/tyGavinZJU/WanXiangHackathon" target="_blank">Github</a>
    </small>
  </div>
</template>

<script>
import Landing from '@/components/Landing.vue'
import Userinfo from '@/components/Userinfo.vue'
import Rawdata from '@/components/Rawdata.vue'
import Diagram from '@/components/Diagram.vue'
import CarRegister from "@/components/CarRegister.vue"
import SmartCarDashboard from "@/components/SmartCarDashboard.vue"
import { Person } from 'blockstack'
import { userSession } from '../userSession'

export default {
  name: 'Home',
  components: { Landing, Userinfo, Rawdata, Diagram,CarRegister,SmartCarDashboard },
  created () {
    this.userSession = userSession
  },
  methods:{
    changeRegister(flag){
      this.isRegister = flag;
    }
  },
  data () {
    return {
      userSession: null,
      user: null,
      isRegister: false,
    }
  },
  mounted () {
    console.log('in!!!!!!:')
    if (userSession.isUserSignedIn()) {
      console.log('in1!!!!!!:')
      this.userData = userSession.loadUserData()
      this.user = new Person(this.userData.profile)
      this.user.username = this.userData.username
    } else if (userSession.isSignInPending()) {
      console.log('in2!!!!!!:')
      userSession.handlePendingSignIn()
        .then((userData) => {
          window.location = window.location.origin
        })
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
