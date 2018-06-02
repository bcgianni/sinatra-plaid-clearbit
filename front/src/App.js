import React from 'react';
import { fetchUtils, Admin, Resource } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';
import { TransactionList } from './transactions';


const httpClient = (url, options = {}) => {
    if (!options.headers) {
        options.headers = new Headers({ Accept: 'application/json' });
    }
    // const token = localStorage.getItem('token');
    const token = process.env.REACT_APP_PLAID_PUBLIC_TOKEN;
    options.headers.set('Authorization', `Bearer ${token}`);
    return fetchUtils.fetchJson(url, options);
}
const dataProvider = jsonServerProvider(process.env.REACT_APP_SERVER_HOST, httpClient);

const App = () => (
    <Admin dataProvider={dataProvider}>
        <Resource name="transactions" list={TransactionList} />
    </Admin>
);

export default App;
