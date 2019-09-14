<template>
    <div class="hello wall">
        <div form-group>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Org:</label>
                <input type="text" class="form-control" id="name" placeholder="Please Input">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Number:</label>
                <input type="text" class="form-control" id="name" placeholder="Please Input">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Type:</label>
                <input type="text" class="form-control" id="name" placeholder="Please Input">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Color:</label>
                <input type="text" class="form-control" id="name" placeholder="Please Input">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Owner's ID Number:</label>
                <input type="text" class="form-control" id="name" placeholder="Please Input">
            </form>
            <button class="btn btn-default" @click="$emit('change_Register',true)">
                Bind with CID
            </button>
            <div>
                <button class="btn btn-default" @click="writeData">
                    Write Data
                </button>
                <button class="btn btn-default" @click="readData">
                    Read Data
                </button>
            </div>
                <!--
                <button class="btn btn-default bg-white" >Sign In With MetaMask</button>
                <br><br>
                -->            
        </div>  
    </div>
    
</template>

<script>
import Landing from '@/components/Landing.vue'
import Userinfo from '@/components/Userinfo.vue'
import Rawdata from '@/components/Rawdata.vue'
import Diagram from '@/components/Diagram.vue'
import { Person } from 'blockstack'
import { userSession } from '../userSession'
var CarRegister_STORAGE_FILE = 'CRtemp.json'
export default {
    components: { Landing, Userinfo, Rawdata, Diagram },
    name: 'CarRegister',
    methods:{
        writeData () {
            userSession.putFile(CarRegister_STORAGE_FILE, JSON.stringify("123"))
        },
        readData(){
            userSession.getFile(CarRegister_STORAGE_FILE) // decryption is enabled by default
            .then((text) => {
                console.log('rawdata:', text)
            })
        }
    }
}
</script>

<style lang="less" scoped>
.title {
    text-align: center
}
.hello {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.wall{
  height: 100%;
  width: 100%;
}
</style>


