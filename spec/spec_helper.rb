# Configure Rails Envinronment
# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'
require 'bundler/setup'
require 'simplecov'
require 'simplecov-summary'
require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'daemons-rails'
# require "codeclimate-test-reporter"
formatters = [SimpleCov::Formatter::SummaryFormatter,SimpleCov::Formatter::HTMLFormatter]
# formatters << CodeClimate::TestReporter::Formatter # if ENV['CODECLIMATE_REPO_TOKEN'] && ENV['TRAVIS']

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)
SimpleCov.start :rails do
  add_filter 'rails'
   at_exit do
     SimpleCov.result.format!
   end
 end

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
  require 'rspec/mocks'
  config.include RSpec::Matchers

  config.mock_with :rspec
  config.infer_spec_type_from_file_location!
 #  config.after(:suite) do
 #    SimpleCov.result.format! if SimpleCov.running
 # end

end
