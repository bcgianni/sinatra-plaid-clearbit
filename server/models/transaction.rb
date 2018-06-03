require 'sinatra/json'
require 'plaid'
require 'date'
require 'pry'

class Transation
  PLAID_CLIENT_ID = ENV['PLAID_CLIENT_ID'] || '5b11b99c16042e00112bd3b0'
  PLAID_CLIENT_SECRET = ENV['PLAID_CLIENT_SECRET'] || '70e64f47f9d4ae295425c214e1df57'
  PLAID_PUBLIC_KEY = ENV['PLAID_PUBLIC_KEY'] || 'e26cc54a3137878e3eec68b77bdbc1'
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

  def self.access_token(token)
    exchange_token_response = client.item.public_token.exchange(token)
    access_token = exchange_token_response['access_token']
  end

  def self.client
    client ||= Plaid::Client.new(env: :sandbox,
                                 client_id: PLAID_CLIENT_ID,
                                 secret: PLAID_CLIENT_SECRET,
                                 public_key: PLAID_PUBLIC_KEY)
  end
end
