require 'sinatra/json'
require 'pry'
require 'securerandom'

require './services/clearbit_service.rb'

class Company
  attr_reader :id, :summary, :legal_name, :logo

  def initialize(company_data = {})
    @id = company_data[:id]
    @uuid = company_data[:uuid] ? company_data[:uuid] : SecureRandom.uuid
    @legal_name = company_data[:legal_name]
    @logo = company_data[:logo]
    @summary = company_data[:summary]
  end

  def self.find_by_name(name)
    company_data = ClearbitService::Company.enrich_by_name(name)
    new(company_data)
  end

  def self.find_by_names(array_names)
    companies = array_names.map do |name|
      find_by_name(name)
    end
  end
end
