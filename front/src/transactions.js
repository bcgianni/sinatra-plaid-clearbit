import React from 'react';
import { List, Datagrid, TextField } from 'react-admin';

export const TransactionList = (props) => (
    <List {...props}>
        <Datagrid>
            <TextField source="id" />
        </Datagrid>
    </List>
);
