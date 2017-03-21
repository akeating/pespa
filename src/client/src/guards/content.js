import api from '../api';

export default function contentGuard(to, from, next) {
  api.isAuthenticated().then(isAuthenticated => {
    if (isAuthenticated) {
      next();
    } else {
      next({ name: 'login' });
    }
  });
};
