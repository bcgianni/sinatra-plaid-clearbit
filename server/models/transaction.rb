require 'sinatra/json'
require 'plaid'
require 'date'
require 'pry'
require './services/plaid_service.rb'

class Transation
  attr_reader :id, :name, :amount, :iso_currency_code, :category_id,
              :type, :date, :account_id, :recurring

  def initialize(transaction_data = {})
    @id = transaction_data['transaction_id']
    @name = transaction_data['name']
    @amount = transaction_data['amount']
    @iso_currency_code = transaction_data['iso_currency_code']
    @category_id = transaction_data['category_id']
    @type = transaction_data['type']
    @date = Date.parse(transaction_data['date'])
    @account_id = transaction_data['account_id']
    @recurring = false
  end

  # return an array of Product objects
  def self.all(token)
    PlaidService::Transactions.fetch(token)[0..10].map do |transaction|
      initialized_transaction = new(transaction)
      initialized_transaction.set_recurrency(token)
      initialized_transaction
    end
  end

  def self.find(token, id)
    all(token).select { |transaction| transaction.id == id }.first
  end

  def self.find_by_ids(token, ids)
    all(token).select { |transaction| ids.include?(transaction.id) }
  end

  def set_recurrency(token)
    @recurring = is_recurrent?(token)
  end

  def is_recurrent?(token)
    transactions = PlaidService::Transactions.fetch_by_dates_month(token, date.prev_month)
    transactions += PlaidService::Transactions.fetch_by_dates_month(token, date.prev_month.prev_month)
    recurring = transactions.select do |transaction|
      transaction["name"] == name && transaction["account_id"] == account_id &&
        transaction["amount"] == amount
    end
    recurring.count >= 2
  end
end
