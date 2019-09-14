<template>
    <div class="hello wall">
        <h1 class="title">Basic Car Info Form</h1>
        <h3><del>Don't</del> Can't be evil</h3>
        <div>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Org:</label>
                <input type="text" class="form-control" id="name" placeholder="请输入名称">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Number:</label>
                <input type="text" class="form-control" id="name" placeholder="请输入名称">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Type:</label>
                <input type="text" class="form-control" id="name" placeholder="请输入名称">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Vehicle's Color:</label>
                <input type="text" class="form-control" id="name" placeholder="请输入名称">
            </form><br>
            <form class="form-inline" role="form">
                <label for="name">Owner's ID Number:</label>
                <input type="text" class="form-control" id="name" placeholder="请输入名称">
            </form>
            <button class="btn btn-default ">
                <router-link to="/dashboard"> Bind with CID </router-link>
            </button>
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
export default {
    components: { Landing, Userinfo, Rawdata, Diagram },
    name: 'CarRegister'
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


