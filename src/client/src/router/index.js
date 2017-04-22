import Vue from 'vue';
import Router from 'vue-router';
import Login from 'components/Login';
import Content from 'components/content/Content';
import Dashboard from 'components/content/Dashboard';
import loginGuard from '../guards/login';
import contentGuard from '../guards/content';

Vue.use(Router);

const router = new Router({
  mode: 'history',
  routes: [
    { path: '/login',
      name: 'login',
      component: Login,
      beforeEnter: loginGuard
    },
    { path: '/a',
      component: Content,
      beforeEnter: contentGuard,
      children: [
        { path: 'dashboard', name: 'dashboard', component: Dashboard },
        { path: '*', redirect: { name: 'dashboard' } }
      ]
    },
    { path: '*', name: 'default', redirect: { name: 'login' } }
  ]
});

export default router;
