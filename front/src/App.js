import React from 'react';
import { Admin, Resource } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';
import { TransactionList } from './transactions';

const dataProvider = jsonServerProvider(process.env.REACT_APP_SERVER_HOST);

const App = () => (
    <Admin dataProvider={dataProvider}>
        <Resource name="transactions" list={TransactionList} />
    </Admin>
);

export default App;
