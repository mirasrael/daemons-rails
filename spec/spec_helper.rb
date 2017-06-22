# Configure Rails Envinronment
# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'
require 'bundler/setup'
require 'simplecov'
require 'simplecov-summary'
require 'rspec/its'
require 'coveralls'
require 'httpi'
require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'daemons-rails'

SimpleCov.start 'rails'
# require "codeclimate-test-reporter"
formatters = [SimpleCov::Formatter::SummaryFormatter,SimpleCov::Formatter::HTMLFormatter]
# formatters << CodeClimate::TestReporter::Formatter # if ENV['CODECLIMATE_REPO_TOKEN'] && ENV['TRAVIS']

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)

SimpleCov.start :rails do
  add_filter 'lib'
   at_exit do
     SimpleCov.result.format!
   end
 end

Coveralls.wear!

# CodeClimate::TestReporter.configure do |config|
#  config.logger.level = Logger::WARN
# end
# CodeClimate::TestReporter.start

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Test::Unit.run = true if defined?(Test::Unit) && Test::Unit.respond_to?(:run=)
RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.infer_spec_type_from_file_location!

  config.mock_with :mocha
  # config.expect_with(:rspec) { |c| c.syntax = :should }
end
