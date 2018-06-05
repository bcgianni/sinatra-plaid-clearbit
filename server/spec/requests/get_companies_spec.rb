require File.expand_path '../spec_helper.rb', __dir__

describe 'Get companies request', :vcr do
  context 'when providing a valid query string' do
    it 'returns all companies infos' do
      VCR.use_cassette('request_clearbit_valid_token', record: :new_episodes) do
        get '/companies?id_like=Uber%7CKFC'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('The official Internet headquarters of Kentucky Fried Chicken and its founder, Colonel Sanders')
      end
    end
  end
end
