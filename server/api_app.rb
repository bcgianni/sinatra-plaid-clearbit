require 'sinatra'

class ApiApp < Sinatra::Base

  before do
    halt 200 if request.request_method == 'OPTIONS'

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'PATCH, POST, PUT, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Total-Count'
    headers['Access-Control-Expose-Headers'] = 'X-Total-Count'

    content_type 'application/json'
  end

  after do
    headers['X-Total-Count'] = "#{response.body[:data].count}"
  end

  get '/transactions' do
    {data: []}
  end


  get '/transactions/:id' do
    {}
  end

  get "/" do
    status 200
  end

end
