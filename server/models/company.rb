require 'sinatra/json'
require 'clearbit'
require 'pry'

class Company

  Clearbit.key = ENV['CLEARBIT_API_KEY'] || '****'

  def self.find_by_name(name)
    response = Clearbit::NameDomain.find(name: name)
    Clearbit::Enrichment::Company.find(domain: response[:domain], stream: false)
  end

  def self.client
    client ||= Plaid::Client.new(env: :sandbox,
                                 client_id: PLAID_CLIENT_ID,
                                 secret: PLAID_CLIENT_SECRET,
                                 public_key: PLAID_PUBLIC_KEY)
  end

end
