<template>
  <div class="container">
    <div class="bs-example">
      <form role="form">
        <div class="form-group">
          <label for="name">Vehicle's Org:</label>
          <input type="text" class="placeholder form-control" id="name" placeholder="Please Input" />
        </div>
        <div class="form-group">
          <label for="name">Vehicle's Number:</label>
          <input type="text" class="form-control" id="name" placeholder="Please Input" />
        </div>
        <div class="form-group">
          <label for="name">Vehicle's Type:</label>
          <input type="text" class="form-control" id="name" placeholder="Please Input" />
        </div>
        <div class="form-group">
          <label for="name">Vehicle's Color:</label>
          <input type="text" class="form-control" id="name" placeholder="Please Input" />
        </div>
        <div class="form-group">
          <label for="name">Owner's ID Number:</label>
          <input type="text" class="form-control" id="name" placeholder="Please Input" />
        </div>
        <button class="btn btn-success bind-text" @click="$emit('change_Register',true)">Bind with CID</button>
        <!--
                <button class="btn btn-default bg-white" >Sign In With MetaMask</button>
                <br><br>
        -->
      </form>
    </div>
  </div>
</template>

<script>
import Landing from "@/components/Landing.vue";
import Userinfo from "@/components/Userinfo.vue";
import Rawdata from "@/components/Rawdata.vue";
import Diagram from "@/components/Diagram.vue";
import { Person } from "blockstack";
import { userSession } from "../userSession";
var CarRegister_STORAGE_FILE = "CRtemp.json";
export default {
  components: { Landing, Userinfo, Rawdata, Diagram },
  name: "CarRegister",
  methods: {
    writeData() {
      userSession.putFile(CarRegister_STORAGE_FILE, JSON.stringify("123"));
    },
    readData() {
      userSession
        .getFile(CarRegister_STORAGE_FILE) // decryption is enabled by default
        .then(text => {
          console.log("rawdata:", text);
        });
    }
  }
};
</script>

<style lang="less" scoped>

.title {
  text-align: center;
}
.hello {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.wall {
  height: 100%;
  width: 100%;
}
.bs-example {
  display: flex;
  flex-direction: column;
  margin: 20px;
  width: 100%;
  justify-content: center;
  align-items: center;
}
.bind-text {
    color: #fff;
    border-radius: 5px;
}

.placeholder .form-control {
    color: #000;
}
</style>


