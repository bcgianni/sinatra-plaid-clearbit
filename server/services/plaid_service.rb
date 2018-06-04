require 'date'
require 'pry'
require_relative 'cache_service.rb'

module PlaidService
  PLAID_CLIENT_ID = ENV['PLAID_CLIENT_ID'] || '***'
  PLAID_CLIENT_SECRET = ENV['PLAID_CLIENT_SECRET'] || '***'
  PLAID_PUBLIC_KEY = ENV['PLAID_PUBLIC_KEY'] || '***'

  module_function

  def default_client
    @default_client ||= Plaid::Client.new(env: :sandbox,
                                          client_id: PLAID_CLIENT_ID,
                                          secret: PLAID_CLIENT_SECRET,
                                          public_key: PLAID_PUBLIC_KEY)
  end

  def self.generate_access_token(public_token)
    exchange_token_response = default_client.item.public_token.exchange(public_token)
    exchange_token_response['access_token']
  end

  module Transactions
    MAX_NUMBER_DAYS = 30

    module_function

    def fetch(access_token, start_date = Date.today, last_date = Date.today - MAX_NUMBER_DAYS)
      fetch_cache(access_token, start_date, last_date) || fetch_plaid(access_token, start_date, last_date)
    end

    def fetch_cache(access_token, start_date, last_date)
      CacheService::Plaid.get_cached_transactions_chunk(access_token, start_date, last_date)
    end

    def fetch_plaid(access_token, start_date, last_date)
      transaction_response = client.transactions.get(access_token, last_date, start_date)
      transactions = transaction_response.transactions

      # the transactions in the response are paginated, so make multiple calls while
      # increasing the offset to retrieve all transactions
      while transactions.length < transaction_response['total_transactions']
        transaction_response = client.transactions.get(access_token,
                                                       last_date,
                                                       start_date,
                                                       offset: transactions.length)
        transactions += transaction_response.transactions
      end

      CacheService::Plaid.set_transactions_chunk_cache(access_token, start_date, last_date, transactions)

      transactions
    end

    def fetch_by_dates_month(access_token, date)
      beginning_of_month = Date.new(date.year, date.month, 1)
      end_of_month = Date.new(date.year, date.month, -1)
      fetch(access_token, end_of_month, beginning_of_month)
    end

    def client
      @client ||= PlaidService.default_client
    end
  end
end
