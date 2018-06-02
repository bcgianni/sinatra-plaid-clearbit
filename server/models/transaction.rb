require 'sinatra/json'
require 'plaid'
require 'date'
require 'pry'

class Transation

  PLAID_CLIENT_ID = ENV['PLAID_CLIENT_ID'] || '****'
  PLAID_CLIENT_SECRET = ENV['PLAID_CLIENT_SECRET'] || '****'
  PLAID_PUBLIC_KEY = ENV['PLAID_PUBLIC_KEY'] || '****'
  PLAID_PUBLIC_TOKEN = ENV['PLAID_PUBLIC_TOKEN']

  # return an array of Product objects
  def self.all(token)
    now = Date.today
    thirty_days_ago = (now - 30)
    transaction_response = client.transactions.get(token, thirty_days_ago, now)
    transactions = transaction_response.transactions

    # the transactions in the response are paginated, so make multiple calls while
    # increasing the offset to retrieve all transactions
    while transactions.length < transaction_response['total_transactions']
      transaction_response = client.transactions.get(access_token,
                                                     thirty_days_ago,
                                                     now,
                                                     offset: transactions.length)
      transactions += transaction_response.transactions
    end

    transactions
  end


  def self.client
    client ||= Plaid::Client.new(env: :sandbox,
                                 client_id: PLAID_CLIENT_ID,
                                 secret: PLAID_CLIENT_SECRET,
                                 public_key: PLAID_PUBLIC_KEY)
  end

end
