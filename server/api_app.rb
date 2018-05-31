require 'sinatra'
require "sinatra/json"

class ApiApp < Sinatra::Base

  before do

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'PATCH, POST, PUT, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Total-Count'
    headers['Access-Control-Expose-Headers'] = 'X-Total-Count'

    halt 200 if request.request_method == 'OPTIONS'
  end

  get '/transactions' do

    transactions = [
      {id: 1}
    ]

    headers['X-Total-Count'] = "#{transactions.count}"

    json transactions
  end


  get '/transactions/:id' do
    {}
  end

  get "/" do
    status 200
  end

end
