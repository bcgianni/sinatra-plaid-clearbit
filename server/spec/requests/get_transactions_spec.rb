require File.expand_path '../spec_helper.rb', __dir__

describe 'Get transactions request', :vcr do
  context 'when providing a valid Authorization header' do
    let(:header) { { 'HTTP_AUTHORIZATION' => 'Bearer access-sandbox-55728eed-1613-4b21-a837-bfef016f3cce' } }
    let(:transaction) do
      Transaction.new(
        'id' => 1,
        'name' => 'nome',
        'amount' => '10',
        'iso_currency_code' => 'R$',
        'category_id' => '123',
        'type' => 'private',
        'date' => '1999/12/12',
        'account_id' => '123',
        'recurring' => false
      )
    end
    let(:array_transactions) { [transaction] }

    it 'returns all transactions' do
      allow(Transaction).to receive(:all).and_return(array_transactions)
      get '/transactions', {}, header
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('[{"id":null,"date":"1999-12-12","transaction_id":null,"company_id":"nome","recurring":false,"amount":"10","name":"nome"}]')
    end

    it 'fetches plaid and returns all transactions' do
      VCR.use_cassette('request_transactions_plaid_valid_header', record: :new_episodes) do
        get '/transactions', {}, header
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('{"id":"7KREBVpaJQSKx9x1l9QahljVDbb4nAfgqBwj6","date":"2018-06-04","transaction_id":"7KREBVpaJQSKx9x1l9QahljVDbb4nAfgqBwj6","company_id":"KFC","recurring":true,"amount":500,"name":"KFC"}')
      end
    end
  end

  context 'when providing an invalid Authorization header' do
    let(:header) { { 'HTTP_AUTHORIZATION' => 'Bearer access-sandbox-AAAA' } }

    it 'returns a Unauthorized 401 response' do
      VCR.use_cassette('request_transactions_invalid_header', record: :new_episodes) do
        get '/transactions', {}, header
        expect(last_response.status).to eq(401)
      end
    end
  end

  context 'when not providing an Authorization header' do
    it 'returns a Unauthorized 401 response' do
      VCR.use_cassette('request_transactions_blank_header', record: :new_episodes) do
        get '/transactions'
        expect(last_response.status).to eq(401)
      end
    end
  end
end
