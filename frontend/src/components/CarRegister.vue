<template>
  <div class="container">
    <div class="bs-example">
      <form role="form" @submit="checkForm">
        <div class="form-group">
          <label for="name">Vehicle's Org:</label>
          <input
            type="text"
            class="placeholder form-control"
            id="name"
            v-model="org"
            placeholder="Please Input"
          />
        </div>
        <div class="form-group">
          <label for="name">Vehicle's Number:</label>
          <input
            type="text"
            class="form-control"
            id="name"
            v-model="number"
            placeholder="Please Input"
          />
        </div>
        <div class="form-group">
          <label for="name">Vehicle's Type:</label>
          <input
            type="text"
            class="form-control"
            id="name"
            v-model="type"
            placeholder="Please Input"
          />
        </div>
        <div class="form-group">
          <label for="name">Vehicle's Color:</label>
          <input
            type="text"
            class="form-control"
            id="name"
            v-model="color"
            placeholder="Please Input"
          />
        </div>
        <div class="form-group">
          <label for="name">Owner's ID Number:</label>
          <input
            type="text"
            class="form-control"
            id="name"
            v-model="IDNumber"
            placeholder="Please Input"
          />
        </div>
        <button class="btn btn-success bind-text" @click="bindCID">Bind with CID</button>
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
  props: {'user':Object},
  data() {
    return {
      errors: [],
      org: null,
      number: null,
      type: null,
      color: null,
      IDNumber: null
    };
  },
  methods: {
    writeData(CID) {
      userSession.putFile(CarRegister_STORAGE_FILE, JSON.stringify(CID));
    },
    readData() {
      userSession
        .getFile(CarRegister_STORAGE_FILE) // decryption is enabled by default
        .then(text => {
          console.log("rawdata:", text);
        });
    },
    bindCID() {
      //console.log("user",this.user)
      this.writeData(this.user.username);
      if (this.org && this.number && this.type && this.color && this.IDNumber)
      {
          alert("Bind Successfully")
          this.$emit("change_Register", true);
      }
      else
        alert("Check your input!!!")
      
    },
    checkForm: function(e) {
      if (this.name && this.age) {
        return true;
      }

      this.errors = [];

      if (!this.name) {
        this.errors.push("Name required.");
      }
      if (!this.age) {
        this.errors.push("Age required.");
      }

      e.preventDefault();
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


