# Configure Rails Envinronment
ENV["RAILS_ENV"] ||= 'test'
require 'bundler/setup'
require 'simplecov'
require 'simplecov-summary'
require 'coveralls'
Coveralls.wear!
formatters = [
  SimpleCov::Formatter::SummaryFormatter,
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
]

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)
SimpleCov.start 'rails' do
   at_exit do
     SimpleCov.result.format!
   end
end

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'daemons-rails'


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

end
