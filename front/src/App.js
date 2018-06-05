import React from 'react';
import { fetchUtils, Admin, Resource } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';
import { TransactionList } from './transactions';
import LoginPage from './LoginPage';
import authProvider from './authProvider'


const httpClient = (url, options = {}) => {
    if (!options.headers) {
        options.headers = new Headers({ Accept: 'application/json' });
    }
    const access_token = localStorage.getItem('access_token');
    options.headers.set('Authorization', `Bearer ${access_token}`);
    return fetchUtils.fetchJson(url, options);
}
const dataProvider = jsonServerProvider(process.env.REACT_APP_SERVER_HOST, httpClient);

const App = () => (
    <Admin title="Sinatra Plaid Clearbit APP" dataProvider={dataProvider} loginPage={LoginPage} authProvider={authProvider} >
        <Resource name="transactions" list={TransactionList} />
        <Resource name="recurrency_check" />
        <Resource name="companies" />
    </Admin>
);

export default App;
