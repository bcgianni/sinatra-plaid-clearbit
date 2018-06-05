require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe PlaidService::Transactions do
  describe '.fetch' do
    context 'when providing a time range' do
      let(:access_token) { 'access-sandbox-55728eed-1613-4b21-a837-bfef016f3cce' }
      let(:start_date) { Date.today }
      let(:last_date) { Date.today - 2 }

      it 'retrieves the all transactions of the period' do
        VCR.use_cassette('transactions_by_period', record: :new_episodes) do
          expect(PlaidService::Transactions.fetch(access_token, start_date, last_date))
            .to eq(
              [{ 'account_id' => 'Qqp5KWJXeVfBj9jz79Q1SMZbRbWVDbTpdzXyR',
                 'account_owner' => nil,
                 'amount' => 500,
                 'category' => ['Food and Drink', 'Restaurants'],
                 'category_id' => '13005000',
                 'date' => '2018-06-05',
                 'iso_currency_code' => 'USD',
                 'location' =>
           { 'address' => nil,
             'city' => nil,
             'lat' => nil,
             'lon' => nil,
             'state' => nil,
             'store_number' => nil,
             'zip' => nil },
                 'name' => 'Tectra Inc',
                 'payment_meta' =>
           { 'by_order_of' => nil,
             'payee' => nil,
             'payer' => nil,
             'payment_method' => nil,
             'payment_processor' => nil,
             'ppd_id' => nil,
             'reason' => nil,
             'reference_number' => nil },
                 'pending' => false,
                 'pending_transaction_id' => nil,
                 'transaction_id' => 'epM5oJvPqaCN9v9Lrv3xfgzQBnnkpbCLG3xEx',
                 'transaction_type' => 'place',
                 'unofficial_currency_code' => nil },
               { 'account_id' => 'Qqp5KWJXeVfBj9jz79Q1SMZbRbWVDbTpdzXyR',
                 'account_owner' => nil,
                 'amount' => 500,
                 'category' => ['Food and Drink', 'Restaurants'],
                 'category_id' => '13005000',
                 'date' => '2018-06-04',
                 'iso_currency_code' => 'USD',
                 'location' =>
                 { 'address' => nil,
                   'city' => nil,
                   'lat' => nil,
                   'lon' => nil,
                   'state' => nil,
                   'store_number' => nil,
                   'zip' => nil },
                 'name' => 'KFC',
                 'payment_meta' =>
                 { 'by_order_of' => nil,
                   'payee' => nil,
                   'payer' => nil,
                   'payment_method' => nil,
                   'payment_processor' => nil,
                   'ppd_id' => nil,
                   'reason' => nil,
                   'reference_number' => nil },
                 'pending' => false,
                 'pending_transaction_id' => nil,
                 'transaction_id' => '7KREBVpaJQSKx9x1l9QahljVDbb4nAfgqBwj6',
                 'transaction_type' => 'place',
                 'unofficial_currency_code' => nil },
               { 'account_id' => 'Qqp5KWJXeVfBj9jz79Q1SMZbRbWVDbTpdzXyR',
                 'account_owner' => nil,
                 'amount' => 500,
                 'category' => %w[Shops Bicycles],
                 'category_id' => '19007000',
                 'date' => '2018-06-04',
                 'iso_currency_code' => 'USD',
                 'location' =>
                 { 'address' => nil,
                   'city' => nil,
                   'lat' => nil,
                   'lon' => nil,
                   'state' => nil,
                   'store_number' => nil,
                   'zip' => nil },
                 'name' => 'Madison Bicycle Shop',
                 'payment_meta' =>
                 { 'by_order_of' => nil,
                   'payee' => nil,
                   'payer' => nil,
                   'payment_method' => nil,
                   'payment_processor' => nil,
                   'ppd_id' => nil,
                   'reason' => nil,
                   'reference_number' => nil },
                 'pending' => false,
                 'pending_transaction_id' => nil,
                 'transaction_id' => 'jWLlAgbJeZfQgpgZGpMjHrQdpggN7eC1eRQww',
                 'transaction_type' => 'place',
                 'unofficial_currency_code' => nil }]
            )
        end
      end
    end
  end
end
