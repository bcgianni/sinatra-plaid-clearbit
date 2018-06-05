import React from 'react';
import { List, Datagrid, TextField, ReferenceField, BooleanField, ImageField } from 'react-admin';

export const TransactionList = (props) => (
    <List {...props} sort={{ field: 'date', order: 'DESC' }} perPage={1000} title="Last 30 days transactions">
        <Datagrid>
            <TextField source="date" />
            <TextField source="amount" label="Amount (US$)" />
            <BooleanField label="Recurrent?" source="recurring" />
            <TextField label="Transation Name" source="name" />
            <ReferenceField label="Company name" source="company_id" reference="companies">
                <TextField source="legal_name" />
            </ReferenceField>
            <ReferenceField label="Company Phone" source="company_id" reference="companies">
                <TextField source="phone" />
            </ReferenceField>
            <ReferenceField label="Company Type" source="company_id" reference="companies">
                <TextField source="type" />
            </ReferenceField>
            <ReferenceField label="Company description" source="company_id" reference="companies">
                <TextField source="description" />
            </ReferenceField>
        </Datagrid>
    </List>
);
