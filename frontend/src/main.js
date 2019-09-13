import Vue from 'vue'
import App from './App.vue'
import router from './router'
import animated from 'animate.css'

window.blockstack = require('blockstack')
window.axios = require('axios')

Vue.config.productionTip = false
Vue.use(animated)

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
