require File.expand_path 'spec_helper.rb', __dir__

describe 'My Sinatra Application' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should allow accessing the home page' do
    options '/'
    expect(last_response).to be_ok
  end
end
