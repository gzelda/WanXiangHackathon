<template>
    <div class="container">
      <div class="row justify-content-md-center">
        <div class="col-md-8 col-md-offset-2">
          <h1 class="page-header align-middle color1">KARMA-Agent System 
            <img :src="user.avatarUrl() ? user.avatarUrl() : '/avatar-placeholder.png'" class="avatar">
            <small><span class="sign-out color1">(<a href="#" @click.prevent="signOut" class="color1">Sign Out</a>)</span></small>
          </h1>
          <h2 class="user-info">
            <small class="float-right color1">
            {{ user.username ? user.username : user.identityAddress }}
            </small>
          </h2>
        </div>
      </div>
    </div>
</template>

<script>
import { userSession } from '../userSession'

export default {
  name: 'userinfo',
  props: ['user'],
  data () {
    return {
    }
  },

  methods: {
    signOut () {
      userSession.signUserOut(window.location.href)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.color1{
  color: rgb(249,246,239);
}

</style>
