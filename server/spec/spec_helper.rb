# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'vcr'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../api_app.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    ApiApp
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.configure do |c|
  c.include RSpecMixin
end
