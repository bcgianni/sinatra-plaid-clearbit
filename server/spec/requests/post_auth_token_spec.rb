require File.expand_path '../spec_helper.rb', __dir__

describe 'Post auth token request', :vcr do
  let(:header) { { 'Content-Type' => 'application/json' } }

  context 'when providing a valid public token' do
    let(:body_with_public_token) { { token: 'public-sandbox-****' }.to_json }

    it 'returns a valid access_token' do
      VCR.use_cassette('request_plaid_valid_token', record: :new_episodes) do
        post '/auth/token', body_with_public_token, header
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq('{"access_token":"access-sandbox-****"}')
      end
    end
  end

  context 'when providing an invalid public token' do
    let(:body_with_public_token) { { token: 'AAAAAAA' }.to_json }

    it 'returns a Unauthorized 401 response' do
      VCR.use_cassette('request_plaid_invalid_token', record: :new_episodes) do
        post '/auth/token', body_with_public_token, header
        expect(last_response.status).to eq(401)
      end
    end
  end
end
