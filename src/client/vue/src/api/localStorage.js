const TOKEN_KEY = 'token';
const TRUST_KEY = 'trust';

class LocalStorage {
  constructor() {
    if (!localStorage) {
      throw new Error('Current browser does not support Local Storage');
    }
    this.localStorage = localStorage;
  }

  setToken(token) {
    this.set(TOKEN_KEY, token);
  }

  getToken() {
    return this.get(TOKEN_KEY);
  }

  clearToken() {
    this.remove(TOKEN_KEY);
  }

  setTrust(val) {
    this.set(TRUST_KEY, val);
  }

  getTrust() {
    return this.get(TRUST_KEY) === 'true';
  }

  set(key, value) {
    this.localStorage[key] = value;
  }

  get(key) {
    return this.localStorage[key] || false;
  }

  setObject(key, value) {
    this.localStorage[key] = JSON.stringify(value);
  }

  getObject(key) {
    return JSON.parse(this.localStorage[key] || '{}');
  }

  remove(key) {
    this.localStorage.removeItem(key);
  }
}

export default new LocalStorage();
