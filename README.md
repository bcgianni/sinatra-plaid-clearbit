# sinatra-plaid-clearbit
Sample sinatra app that retrieves company info from Clearbit to enrich Plaid transactions.

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

Env vars for the frontend app:

REACT_APP_PLAID_PUBLIC_KEY = Plaid public key to use Plaid link

REACT_APP_SERVER_HOST = host address where the backend runs

### Backend

#### To run:

```
cd server
bundle install
rackup
```

Env vars that need to be correctly configured:

CLEARBIT_API_KEY = Clearbit's API Key

PLAID_CLIENT_ID = Plaid integration client_id

PLAID_CLIENT_SECRET = Plaid  integration secret

PLAID_PUBLIC_KEY = Plaid integration public key

REDIS_URL = Redis config url for caching the external requests

#### To run tests:

while on server folder:

```
rspec
```
