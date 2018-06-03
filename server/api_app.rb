require 'sinatra'
require 'sinatra/jbuilder'
require_relative 'models/transaction.rb'
require_relative 'models/company.rb'
require "./lib/api_helper"
require 'pry'

class ApiApp < Sinatra::Base
  include ApiHelper

  before do
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'PATCH, POST, PUT, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Total-Count, Authorization'
    headers['Access-Control-Expose-Headers'] = 'X-Total-Count'

    halt 200 if request.request_method == 'OPTIONS'
  end

  get '/transactions' do
    token = request.env['HTTP_AUTHORIZATION'].split('Bearer ').last

    @transactions = Transation.all(token)

    headers['X-Total-Count'] = @transactions.count.to_s

    jbuilder :transactions
  end

  get '/recurrencies/:transaction_id' do
    # get transaction's date and transactions of month before
    {}
  end

  get '/companies/:name' do
    @company = Company.find_by_name(params[:name])
    jbuilder :company
  end

  post '/auth/token' do
    with_checked_body(request.body) do |parsed_body|
      @access_token = Transation.access_token(parsed_body["token"])
    end

    jbuilder :access_token
  end

  get '/' do
    status 200
  end
end
