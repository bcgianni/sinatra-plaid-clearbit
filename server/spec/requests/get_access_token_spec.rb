require File.expand_path '../spec_helper.rb', __dir__

describe 'Get access token request', :vcr do
  let(:header) { { 'Content-Type' => 'application/json' } }

  context 'when providing a valid public token' do
    let(:body_with_public_token) { { token: 'AAAAAAA' }.to_json }
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
