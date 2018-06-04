require 'date'
require 'pry'
require 'clearbit'
require_relative 'cache_service.rb'

module ClearbitService
  module Company

    Clearbit.key = ENV['CLEARBIT_API_KEY'] || 'sk_8ea815cff9bf28d8e8491a010c138584'

    module_function

    def enrich_by_name(name)
      return clearbit_company_object(name)
    end

    def clearbit_company_object(name)
      domain = get_domain_by_name(name.split(" ").first) # Get first name to improve accuracy
      return nil_company(name) unless domain
      clbit_info = get_company_info_by_domain(domain)
      {
        "id": name,
        "uuid": clbit_info["id"],
        "logo": clbit_info["logo"],
        "legal_name": clbit_info["legalName"],
        "summary": summarize(clbit_info)
      }
    end

    def get_company_info_by_domain(domain)
      company_info_by_cache(domain) || company_info_by_clearbit(domain)
    end

    def get_domain_by_name(name)
      response = domain_by_cache(name) || domain_by_clearbit(name)
      return nil unless response
      response["domain"]
    end

    def company_info_by_cache(domain)
      CacheService::ClearBit.get_cached_company_info(domain)
    end

    def company_info_by_clearbit(domain)
      response = Clearbit::Enrichment::Company.find(
                  domain: domain,
                  stream: false
                 )
      CacheService::ClearBit.set_company_info_cache(domain, response)
      response
    end

    def domain_by_cache(name)
      CacheService::ClearBit.get_cached_domain(name)
    end

    def domain_by_clearbit(name)
      response = Clearbit::NameDomain.find(name: name)
      CacheService::ClearBit.set_domain_cache(name, response)
      response
    end

    def nil_company(name)
      {
        "uuid": nil,
        "id": name,
        "legal_name": name,
        "logo": nil,
        "summary": nil
      }
    end

    def summarize(clbit_info)
      # Use inspect until I have a better idea
      clbit_info.inspect
    end

  end
end
