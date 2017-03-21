import api from '../api';

export default function loginGuard(to, from, next) {
  api.isAuthenticated().then(isAuthenticated => {
    if (isAuthenticated) {
      next({ name: 'dashboard' });
    } else {
      next();
    }
  });
};
