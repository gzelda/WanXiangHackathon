<template>
  <div class="block">
    <div class="gaia_ok"></div>
    <div class="gaia_upload"></div>
    <div class="eth"></div>
  </div>
</template>

<script>
import Velocity from 'velocity-animate'
export default {
  name: 'diagram',
  props: ['user'],
  data () {
    return {

    }
  },
  methods: {

  }
}
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.gaia_ok{
    background: url(../assets/gaia_ok.png);
    height:100px;
    width:100px;
    background-size:100% 100%;
}

.gaia_upload{
    background: url(../assets/gaia_upload.png);
    height:100px;
    width:100px;
    background-size:100% 100%;
}

.eth{
    background: url(../assets/eth.png);
    height:100px;
    width:100px;
    background-size:100% 100%;
}
</style>
