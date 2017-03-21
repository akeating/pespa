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
      name: 'container',
      component: Content,
      beforeEnter: contentGuard,
      children: [
        { path: 'dashboard', name: 'dashboard', component: Dashboard }
      ]
    },
    { path: '*', name: 'default', redirect: '/a/dashboard' }
  ]
});

export default router;
