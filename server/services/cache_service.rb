require 'redis'
require 'pry'
require 'json'

module CacheService
  CACHING_TIME_IN_SECONDS = 3600
  REDIS_URL = ENV['REDIS_URL'] || 'redis://localhost:32771'

  module_function

  def get(key)
    redis_client.get(key)
  end

  def set(key, value)
    redis_client.set(key, value)
    expire(key)
  end

  def expire(key)
    redis_client.expire(key, CACHING_TIME_IN_SECONDS)
  end

  def redis_client
    @redis_client ||= Redis.new(url: REDIS_URL)
  end

  module ClearBit
    module_function

    def set_domain_cache(name, response)
      CacheService.set("clearbit:name:#{name}", response.to_json)
    end

    def get_cached_domain(name)
      response_string = CacheService.get("clearbit:name:#{name}")
      JSON.parse(response_string) if response_string
    end

    def set_company_info_cache(domain, info)
      CacheService.set("clearbit:domain:#{domain}", info.to_json)
    end

    def get_cached_company_info(domain)
      info_string = CacheService.get("clearbit:domain:#{domain}")
      JSON.parse(info_string) if info_string
    end
  end

  module Plaid
    module_function

    def set_transactions_chunk_cache(start_date, last_date, transactions)
      CacheService.set("plaid:transactions:#{start_date}:#{last_date}", transactions.to_json)
    end

    def get_cached_transactions_chunk(start_date, last_date)
      transactions_string = CacheService.get("plaid:transactions:#{start_date}:#{last_date}")
      JSON.parse(transactions_string) if transactions_string
    end
  end
end
