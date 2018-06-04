require 'redis'
require 'pry'
require 'json'

module CacheService
  CACHING_TIME_IN_SECONDS = 3600
  REDIS_URL = ENV['REDIS_URL'] || 'redis://localhost:32771'

  module_function

  def get(key)
    value = redis_client.get(key)
    JSON.parse(value) if value
  end

  def set(key, value)
    redis_client.set(key, value.to_json)
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
      CacheService.set("clearbit:name:#{name}", response)
    end

    def get_cached_domain(name)
      CacheService.get("clearbit:name:#{name}")
    end

    def set_company_info_cache(domain, info)
      CacheService.set("clearbit:domain:#{domain}", info)
    end

    def get_cached_company_info(domain)
      CacheService.get("clearbit:domain:#{domain}")
    end
  end

  module Plaid
    module_function

    def set_transactions_chunk_cache(token, start_date, last_date, transactions)
      CacheService.set("plaid:#{token}:transactions:#{start_date}:#{last_date}", transactions)
    end

    def get_cached_transactions_chunk(token, start_date, last_date)
      CacheService.get("plaid:#{token}:transactions:#{start_date}:#{last_date}")
    end
  end
end
