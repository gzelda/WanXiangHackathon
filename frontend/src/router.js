import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import SmartCarDashboard from './components/SmartCarDashboard.vue'
import CarRegister from './components/CarRegister.vue'

Vue.use(Router)
// 创建路由器
export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/carRegister',
      component: CarRegister
    },
    {
      path: '/dashboard',
      component: SmartCarDashboard
    }

  ]
})
