# sinatra-plaid-clearbit
Sample sinatra app that retrieves company info from Clearbit to enrich Plaid transactions

### FrontEnd

Ok, so, the react front is based on react-admin:

https://github.com/marmelab/react-admin

And also on:

https://github.com/pbernasconi/react-plaid-link


To run the front end part:

```
cd front
yarn
yarn start
```

### Backend

To run:

```
cd server
bundle install
rackup
```

To run tests:

while on server folder:

```
rspec
```
