require 'sinatra/json'
require 'pry'
require 'securerandom'

require './services/clearbit_service.rb'

class Company
  attr_reader :id, :description, :legal_name, :logo, :phone, :type,
              :estimated_annual_revenue, :uuid

  def initialize(company_data = {})
    @id = company_data[:id]
    @uuid = company_data[:uuid] ? company_data[:uuid] : SecureRandom.uuid
    @legal_name = company_data[:legal_name]
    @logo = company_data[:logo]
    @description = company_data[:description]
    @phone = company_data[:phone]
    @type = company_data[:type]
    @estimated_annual_revenue = company_data[:estimated_annual_revenue]
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
