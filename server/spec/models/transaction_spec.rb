require File.expand_path '../spec_helper.rb', __dir__

describe Transaction, :vcr do
  describe '#initialize' do
    it 'correctly creates the transaction object' do
      @transaction = Transaction.new(
        'id' => '1',
        'name' => 'nome',
        'amount' => '10',
        'iso_currency_code' => 'R$',
        'category_id' => '123',
        'type' => 'private',
        'date' => '1999/12/12',
        'account_id' => '123',
        'recurring' => false
      )

      expect(@transaction.name).to eq('nome')
      expect(@transaction.amount).to eq('10')
      expect(@transaction.iso_currency_code).to eq('R$')
      expect(@transaction.category_id).to eq('123')
      expect(@transaction.account_id).to eq('123')
      expect(@transaction.type).to eq('private')
    end
  end

  describe '.all' do
    let(:access_token) { 'access-sandbox-55728eed-1613-4b21-a837-bfef016f3cce' }

    it 'retrieves all transactions for the last 30 days' do
      VCR.use_cassette('transaction_model_all', record: :new_episodes) do
        @transactions = Transaction.all(access_token)

        expect(@transactions.count).to eq(16)
        expect(@transactions.first.class).to eq(Transaction)
      end
    end
  end
end
