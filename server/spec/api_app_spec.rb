require File.expand_path 'spec_helper.rb', __dir__

describe 'Api Sinatra App' do
  context 'when requesting the root path' do
    it 'returns 200 ok' do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
