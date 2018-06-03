# spec/spec_helper.rb
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../api_app.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    ApiApp
  end
end

RSpec.configure { |c| c.include RSpecMixin }
