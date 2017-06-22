#!/usr/bin/env rake
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'appraisal'
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec) do |spec|
  default_options = ['--colour']
  default_options.concat(['--backtrace', '--fail-fast']) if ENV['DEBUG']
  spec.rspec_opts = default_options
  spec.verbose = true
end

YARD::Config.options[:load_plugins] = true
YARD::Config.load_plugins

# dirty hack for YardocTask
::Rake.application.class.class_eval do
  alias_method :last_comment, :last_description
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb', 'spec/**/*_spec.rb'] # optional
  t.options = ['--any', '--extra', '--opts', '--markup-provider=redcarpet', '--markup=markdown', '--debug'] # optional
  t.stats_options = ['--list-undoc'] # optional
end

desc 'Default: run the unit tests.'
task default: [:all]

desc 'Test the plugin under all supported Rails versions.'
task :all do |_t|
  if ENV['TRAVIS']
    # require 'json'
    # puts JSON.pretty_generate(ENV.to_hash)
    if ENV['BUNDLE_GEMFILE'] =~ /gemfiles/
      appraisal_name = ENV['BUNDLE_GEMFILE'].scan(/rails\_(.*)\.gemfile/).flatten.first
      command_prefix = "appraisal rails-#{appraisal_name}"
      exec("#{command_prefix} bundle install && #{command_prefix} bundle exec rspec && bundle exec rake coveralls:push ")
    else
      exec(' bundle exec appraisal install && bundle exec rake appraisal spec && bundle exec rake coveralls:push')
    end
  else
    exec('bundle exec appraisal install && bundle exec rake appraisal spec')
  end
end

task :docs do
  exec('bundle exec inch --pedantic && bundle exec yard --list-undoc')
end
