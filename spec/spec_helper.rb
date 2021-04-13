require_relative '../config/environment'
require 'vcr'
require 'webmock'
require "rack/test"
require "rspec-html-matchers"

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include Rack::Test::Methods
  config.include RSpecHtmlMatchers
end

VCR.configure do |config|
  config.cassette_library_dir = 'fixture/cassettes'
  config.hook_into :webmock
  # config.ignore_localhost = true
  # config.configure_rspec_metadata!
end
