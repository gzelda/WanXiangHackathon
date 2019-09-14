<template>
<div class="container">
  <div class="con2">
    <div class="terminal">
        <div class="terminal_text" id="terminal_text">
        </div>
        <div style="width:20px"></div>
        <div class="terminal_text2" id="terminal_text2">
        </div>
    </div>

    <div class="con3" v-if="false">
      <div class="con2r" style="width:33%">
          <div class="device pic"></div>
      </div>
      <div class="con2r" style="width:33%">
          <div class="gaia_ok pic" v-if="upload"></div>
          <div class="gaia_upload pic" v-if="!upload"></div>
      </div>
      <div class="con2r" style="width:33%">
          <div class="eth pic"></div>
      </div>
    </div>
  </div>
</div>
</template>

<script>

import { userSession } from '../userSession'
var STORAGE_FILE = 'sd.json'

var crypto = require('crypto')
var senRawData = require('./SensorData.json')
var senData = senRawData.data
console.log(web3)
//console.log(senData.length)
export default {

  name: 'rawdata',
  props: ['user'],
  data () {
    return {
      timer: '',
      count: 0,
      data: '',
      upload: false,
      timer2: ''
    }
  },
  methods: {
    sensorOutput () {
      userSession.putFile(STORAGE_FILE, JSON.stringify(this.data))
    },
    sensorInput () {
      //console.log(this.count)
      var t = senData[this.count].sensorSteam
      this.data += t
      // console.log(t)
      var textdiv = document.getElementById('terminal_text')
      var reg = /(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-)+)/g
      var url = t.match(reg)
      if (url != null) {
        textdiv.innerHTML += '<a target="_blank" href="' + t + '">' + senData[this.count].sensorSteam + '</a><br>'
      } else {
        textdiv.innerHTML += t + '<br>'
      }
      textdiv.scrollTop = textdiv.scrollHeight

      // this.data += senData[this.count].sensorSteam + ' \n '
      this.count = this.count + 1
      if (this.count == senData.length) this.count = 0
    },
    fingerprint () {
      var md5 = crypto.createHash('md5')
      var result = md5.update(this.data)

      var t = result.digest('hex')
      //console.log(t)
      var textdiv = document.getElementById('terminal_text2')
      textdiv.innerHTML += t + '<br>'
      textdiv.scrollTop = textdiv.scrollHeight
      var ContractABI = web3.eth.contract([
        {
          'constant': false,
          'inputs': [
            {
              'name': 'newHash',
              'type': 'string'
            }
          ],
          'name': 'recordHash',
          'outputs': [
            {
              'name': '',
              'type': 'uint256'
            }
          ],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {
              'name': 'newOwner',
              'type': 'address'
            }
          ],
          'name': 'transferOwnership',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        },
        {
          'inputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'constructor'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'name': 'index',
              'type': 'uint256'
            },
            {
              'indexed': false,
              'name': 'recordedHash',
              'type': 'string'
            }
          ],
          'name': 'RecordHash',
          'type': 'event'
        },
        {
          'anonymous': false,
          'inputs': [
            {
              'indexed': true,
              'name': 'previousOwner',
              'type': 'address'
            },
            {
              'indexed': true,
              'name': 'newOwner',
              'type': 'address'
            }
          ],
          'name': 'OwnershipTransferred',
          'type': 'event'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'owner',
          'outputs': [
            {
              'name': '',
              'type': 'address'
            }
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [],
          'name': 'recordNum',
          'outputs': [
            {
              'name': '',
              'type': 'uint256'
            }
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': true,
          'inputs': [
            {
              'name': '',
              'type': 'uint256'
            }
          ],
          'name': 'records',
          'outputs': [
            {
              'name': '',
              'type': 'string'
            }
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        }
      ])
      var Contract = ContractABI.at('0xd92aac5e0bf1116ac366d590329459eab3679671')
      Contract.recordHash(t,
        	function (err, res) {
        		if (!err) alert('transaction success')
        		else alert('transaction falied')
  			})
    },
    fetchData () {
      userSession.getFile(STORAGE_FILE) // decryption is enabled by default
        .then((text) => {
          //console.log('rawdata:', text)
          var md5 = crypto.createHash('md5')
          var result = md5.update(text)

          var t = result.digest('hex')
          //console.log('crptoData', t)
        })
    },
    ssync () {
      this.timer = setInterval(this.sensorInput, 100)
      this.timer2 = setInterval(this.fingerprint, 15000)
      this.time3 = setInterval(this.sensorOutput, 10000)
    }

  },
  mounted () {
    this.ssync()
    this.fetchData()
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.container{
  width: 80%;
}

.con2 {
  display:flex;
  flex-direction: column;
  height:100%;
  justify-content: center;
  align-content: center;
  padding:0 0 0 0;
}

.con2r {
  display:flex;
  height:100%;
  justify-content: center;
  align-content: center;
}

.con3 {
  display:flex;
  height:100%;
}

.terminal{
    border-style:solid;
    width: 100%;
    height: 300px;
    border-width: 1px 1px 1px 1px;
    border-color: rgb(249,246,239);
    display:flex;
    justify-content: center;
    align-content: center;
}
.terminal_text2{
    overflow-y:scroll;
    background-color: rgb(249,246,239);
    caret-color: white;
    text-shadow: 0px 0px 0px rgb(152,65,36);
    -webkit-text-fill-color: transparent;
    font-size: 14px;
    font-weight: 500;
    letter-spacing:1px;
    padding:10px 0px 0px 10px;
    border-style: none;
    width:30%
}
.terminal_text{
    overflow-y:scroll;
    background-color: rgb(249,246,239);
    caret-color: white;
    text-shadow: 0px 0px 0px rgb(253,97,87) ;
    -webkit-text-fill-color: transparent;
    font-size: 14px;
    font-weight: 500;
    letter-spacing:1px;
    padding:10px 0px 0px 10px;
    border-style: none;
    width:70%;
    scrollbar-base-color:#ff6600;
}

.gaia_ok{
    background: url(../assets/gaia_ok.png);
}

.gaia_upload{
    background: url(../assets/gaia_upload.png);
}

.eth{
    background: url(../assets/eth.png);
}

.device{
    background: url(../assets/device.png);

}

.pic{
    height:150px;
    width:150px;
    background-size:100% 100%;
}

</style>
