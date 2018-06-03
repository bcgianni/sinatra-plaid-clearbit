import { AUTH_LOGIN, AUTH_LOGOUT, AUTH_ERROR, AUTH_CHECK } from 'react-admin';

export default (type, params) => {
    if (type === AUTH_LOGIN) {
        const { token, metadata } = params;
        const request = new Request(`${process.env.REACT_APP_SERVER_HOST}/auth/token`, {
          method: 'POST',
          body: JSON.stringify({ token }),
          headers: new Headers({ 'Content-Type': 'application/json' })
        });
        return fetch(request)
          .then(response => {
            if (response.status < 200 || response.status >= 300) {
              throw new Error();
            }
            return response.json();
        })
        .then(({ access_token }) => {
          localStorage.setItem('access_token', access_token);
          return token;
        });
    }
    if (type === AUTH_LOGOUT) {
        localStorage.removeItem('access_token');
        return Promise.resolve();
    }
    if (type === AUTH_ERROR) {
        const status  = params.status;
        if (status === 401 || status === 403) {
            localStorage.removeItem('access_token');
            return Promise.reject();
        }
        return Promise.resolve();
    }
    if (type === AUTH_CHECK) {
        return localStorage.getItem('access_token') ? Promise.resolve() : Promise.reject();
    }
    return Promise.resolve();
}
