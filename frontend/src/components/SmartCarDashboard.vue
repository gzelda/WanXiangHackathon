<template>
  <div class="container">
    <h1 class="title">Dashboard</h1>
    <div class="row">
      <!-- driver -->
      <div class="car-view col-sm">
        <h4>Driver</h4>
        <ul>
          <li>gas: {{ driver.gas.substr() }}</li>
          <li>direction: {{ driver.direction }}</li>
          <li>brake: {{ driver.brake }}</li>
          <li>is_hand_brake {{ driver.is_hand_brake }}</li>
          <li>is_reverse_gear: {{ driver.is_reverse_gear }}</li>
          <li>forward_gear: {{ driver.forward_gear }}</li>
        </ul>
      </div>
      <!-- vehicle-info -->
      <div class="person-view col-sm">
        <h4 class="title">Vehicle</h4>
        <ul>
          <li>loc_x: {{ vehicle.loc_x }}</li>
          <li>loc_y: {{ vehicle.loc_y }}</li>
          <li>loc_z: {{ vehicle.loc_z }}</li>
          <li>pitch: {{ vehicle.pitch }}</li>
          <li>yaw: {{ vehicle.yaw }}</li>
          <li>roll: {{ vehicle.roll }}</li>
        </ul>
      </div>

      <div class="car-vision col-sm">
        <h4>图</h4>
        <img style="width: 200px;height: 100px;" :src="getImgUrl()"/>
        <!-- <img src="../assets/datasets/output0/006579_rgb.png"/> -->
      </div>
    </div>

    <div class="con2">
      <div class="terminal">
        <div class="terminal_text" id="terminal_text"></div>
        <div style="width:20px"></div>
        <div class="terminal_text2" id="terminal_text2"></div>
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
import { userSession } from "../userSession";

var STORAGE_FILE = "sd.json";
var crypto = require("crypto");
var senRawData = require("./SensorData.json");
var output0RawData = require("../assets/datasets/output0.json");

var senData = senRawData.data;
var output0Data = output0RawData.data; 

// console.log(web3);
// console.log("senData length: ", senData.length);
// console.log("output0 data length: ", output0Data.length);
// console.log("output0 第一条数据: ", output0Data[0]);

export default {
  name: "scdb",
  //   props: ["user"],
  data() {
    return {
      image_datset_base: '/static/datasets/output0/',
      timer: "",
      count: 0,
      data: "",
      upload: false,
      timer2: "",
      frame: 3798,
      countFrame: 0,
      frameSecond: 30,
      framesUpdateInterval: 15,
      // vehicle-info
      vehicle: {
        loc_x: "1",
        loc_y: "2",
        loc_z: "3",
        pitch: "",
        yaw:"",
        roll: "",
      },
      // driver
      driver: {
        gas: "",  
        direction: "",
        brake:"",
        is_hand_brake: "",
        is_reverse_gear: "",
        forward_gear: ""
      },
    };
  },
  computed: {
      
  },
  methods: {
    getImgUrl() {
        let img_url = this.image_datset_base + "00" + this.frame + '_rgb.png'
        console.log(img_url)
        return img_url
    },
    sensorOutput() {
      userSession.putFile(STORAGE_FILE, JSON.stringify(this.data));
    },
    sensorInput() {
    //   console.log(this.count);
      var t = senData[this.count].sensorSteam;
      this.data += t;
      // console.log(t)
      var textdiv = document.getElementById("terminal_text");
      var reg = /(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-)+)/g;
      var url = t.match(reg);
      if (url != null) {
        textdiv.innerHTML +=
          '<a target="_blank" href="' +
          t +
          '">' +
          senData[this.count].sensorSteam +
          "</a><br>";
      } else {
        textdiv.innerHTML += t + "<br>";
      }
      textdiv.scrollTop = textdiv.scrollHeight;

      // this.data += senData[this.count].sensorSteam + ' \n '
      this.count = this.count + 1;
      if (this.count == senData.length) this.count = 0;
    },
    fingerprint() {
      var md5 = crypto.createHash("md5");
      var result = md5.update(this.data);

      var t = result.digest("hex");
      console.log(t);
      var textdiv = document.getElementById("terminal_text2");
      textdiv.innerHTML += t + "<br>";
      textdiv.scrollTop = textdiv.scrollHeight;
      var ContractABI = web3.eth.contract([
        {
          constant: false,
          inputs: [
            {
              name: "newHash",
              type: "string"
            }
          ],
          name: "recordHash",
          outputs: [
            {
              name: "",
              type: "uint256"
            }
          ],
          payable: false,
          stateMutability: "nonpayable",
          type: "function"
        },
        {
          constant: false,
          inputs: [
            {
              name: "newOwner",
              type: "address"
            }
          ],
          name: "transferOwnership",
          outputs: [],
          payable: false,
          stateMutability: "nonpayable",
          type: "function"
        },
        {
          inputs: [],
          payable: false,
          stateMutability: "nonpayable",
          type: "constructor"
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              name: "index",
              type: "uint256"
            },
            {
              indexed: false,
              name: "recordedHash",
              type: "string"
            }
          ],
          name: "RecordHash",
          type: "event"
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              name: "previousOwner",
              type: "address"
            },
            {
              indexed: true,
              name: "newOwner",
              type: "address"
            }
          ],
          name: "OwnershipTransferred",
          type: "event"
        },
        {
          constant: true,
          inputs: [],
          name: "owner",
          outputs: [
            {
              name: "",
              type: "address"
            }
          ],
          payable: false,
          stateMutability: "view",
          type: "function"
        },
        {
          constant: true,
          inputs: [],
          name: "recordNum",
          outputs: [
            {
              name: "",
              type: "uint256"
            }
          ],
          payable: false,
          stateMutability: "view",
          type: "function"
        },
        {
          constant: true,
          inputs: [
            {
              name: "",
              type: "uint256"
            }
          ],
          name: "records",
          outputs: [
            {
              name: "",
              type: "string"
            }
          ],
          payable: false,
          stateMutability: "view",
          type: "function"
        }
      ]);
      var Contract = ContractABI.at(
        "0xd92aac5e0bf1116ac366d590329459eab3679671"
      );
      Contract.recordHash(t, function(err, res) {
        if (!err) alert("transaction success");
        else alert("transaction falied");
      });
    },
    fetchData() {
      userSession
        .getFile(STORAGE_FILE) // decryption is enabled by default
        .then(text => {
          console.log("rawdata:", text);
          var md5 = crypto.createHash("md5");
          var result = md5.update(text);

          var t = result.digest("hex");
          console.log("crptoData", t);
        });
    },
    
    // vehicle-info
    updateFrame() {
        console.log("frame count: ", this.countFrame)
        this.countFrame += this.frameSecond
        this.countFrame %= output0Data.length
        console.log(output0Data[this.countFrame])
        this.vehicle = output0Data[this.countFrame].vehicle_info
        this.driver = output0Data[this.countFrame].driver
        this.frame = output0Data[this.countFrame].frame
    },
    ssync() {
      this.timer = setInterval(this.sensorInput, 10000);
      this.timer2 = setInterval(this.fingerprint, 15000);
      this.time3 = setInterval(this.sensorOutput, 10000);
      setInterval(this.updateFrame, 
        1000.0 * this.framesUpdateInterval / this.frameSecond);
    },
  },
  mounted() {
    this.ssync();
    this.fetchData();
  }
};
</script>

<style scoped>
.container {
  width: 80%;
}

.con2 {
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  align-content: center;
  padding: 100px 0 0 0;
}

.con2r {
  display: flex;
  height: 100%;
  justify-content: center;
  align-content: center;
}

.con3 {
  display: flex;
  height: 100%;
}

.person-view {
  width: 100%;
  height: 200px;
  background-color: #eee;
  margin: 1em;
  color: #ff6600;
}

.car-view {
  width: 100%;
  height: 200px;
  background: #eee;
  margin: 1em;
  color: #ff6600;
}

.car-vision {
  width: 100%;
  height: 200px;
  background: #eee;
  margin: 1em;
  color: #ff6600;
}

.terminal {
  border-style: solid;
  width: 100%;
  height: 300px;
  border-width: 1px 1px 1px 1px;
  border-color: rgb(249, 246, 239);
  display: flex;
  justify-content: center;
  align-content: center;
}
.terminal_text2 {
  overflow-y: scroll;
  background-color: rgb(249, 246, 239);
  caret-color: white;
  text-shadow: 0px 0px 0px rgb(152, 65, 36);
  -webkit-text-fill-color: transparent;
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 1px;
  padding: 10px 0px 0px 10px;
  border-style: none;
  width: 30%;
}
.terminal_text {
  overflow-y: scroll;
  background-color: rgb(249, 246, 239);
  caret-color: white;
  text-shadow: 0px 0px 0px rgb(253, 97, 87);
  -webkit-text-fill-color: transparent;
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 1px;
  padding: 10px 0px 0px 10px;
  border-style: none;
  width: 70%;
  scrollbar-base-color: #ff6600;
}

.gaia_ok {
  background: url(../assets/gaia_ok.png);
}

.gaia_upload {
  background: url(../assets/gaia_upload.png);
}

.eth {
  background: url(../assets/eth.png);
}

.device {
  background: url(../assets/device.png);
}

.pic {
  height: 150px;
  width: 150px;
  background-size: 100% 100%;
}
</style>
