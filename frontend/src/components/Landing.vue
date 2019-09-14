<template>
  <div class="hello wall">
    <div>
      <h1>Vehicle-Assistant IOT System</h1>
      <h3><del>Don't</del> Can't be evil</h3>
      <!--
      <button class="btn btn-default bg-white" >Sign In With MetaMask</button>
      <br><br>
      -->
      <button class="btn btn-default bg-white" @click.prevent="signIn">Vehicle Sign In</button>
      <!-- <button class="btn" @click="goDashboard">GO Dashboard</button> -->
      <div>
          <!--
          <button class="btn btn-default ">
            <router-link to="/carRegister"> Vehicle Sign In</router-link>
          </button>
          -->
          <button class="btn btn-default ">
            <router-link to="/dashboard"> BING DEBUG Go to Car Dashboard</router-link>
          </button>

          
      </div>
      
    </div>
  </div>
</template>
<script>
import { userSession } from '../userSession'

export default {
  name: 'landing',
  data () {
    return {
    }
  },
  methods: {
    signIn () {
      
      console.log(web3.eth.accounts[0])
      web3.eth.sign(web3.eth.accounts[0],
        '0x9dd2c369a187b4e6b9c402f030e50743e619301ea62aa4c0737d4ef7e10a3d49', function (a) {
          console.log(a)
          userSession.redirectToSignIn()
        })
        
      /*
      then(res => {
          userSession.redirectToSignIn()
      });
      */
      //userSession.redirectToSignIn()
    },
    goDashboard () {
      alert('Dashbaord!')
    }
  },
  mounted () {
    window.addEventListener('load', async () => {
    // Modern dapp browsers...
      if (window.ethereum) {
        window.web3 = new Web3(ethereum)
        try {
          // Request account access if needed
          await ethereum.enable()
          // Acccounts now exposed
          web3.eth.sendTransaction({/* ... */})
        } catch (error) {
          // User denied account access...
        }
      }
      // Legacy dapp browsers...
      else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider)
        // Acccounts always exposed
        web3.eth.sendTransaction({/* ... */})
      }
      // Non-dapp browsers...
      else {
        console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
      }
    })
    console.log(web3.eth.accounts[0])
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="less" scoped>
.hello {
  display: flex;
  align-items: center;
  justify-content: center;
}
.wall{
  height: 100%;
  width: 100%;
}
</style>
