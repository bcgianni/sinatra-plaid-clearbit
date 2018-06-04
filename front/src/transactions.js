import React from 'react';
import { List, Datagrid, TextField, ReferenceField, BooleanField, ImageField } from 'react-admin';

export const TransactionList = (props) => (
    <List {...props}>
        <Datagrid>
            <TextField source="id" />
            <ReferenceField label="Company info" source="company_id" reference="companies">
                <TextField source="summary" />
            </ReferenceField>
            <BooleanField label="Recurrent?" source="recurring" />
        </Datagrid>
    </List>
);
