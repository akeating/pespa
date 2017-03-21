import Vue from 'vue';
import Login from 'src/components/Login';

describe('Login.vue', () => {
  it('should render correct contents', () => {
    const Constructor = Vue.extend(Login);
    const vm = new Constructor().$mount();
    expect(vm.$el.querySelector('.login-button').textContent.trim())
      .to.equal('login');
  });
});
