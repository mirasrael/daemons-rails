# -*- encoding: utf-8 -*-
require 'date'
require File.expand_path('../lib/daemons/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors                     = ["mirasrael"]
  gem.email                       = []
  gem.description                 = %q{daemonization support for Rails 3+}
  gem.summary                     = %q{daemonization support for Rails 3+}
  gem.homepage                    = ""
  gem.licenses                    = %w(MIT GPL-2)

  gem.executables                 = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files                       = `git ls-files`.split("\n")
  gem.test_files                  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name                        = "daemons-rails"
  gem.require_paths               = ["lib"]
  gem.version                     = Daemons::Rails.gem_version
  gem.platform                    = Gem::Platform::RUBY
  gem.date                        = Date.today
  gem.required_ruby_version       = '>= 2.0'
  gem.required_rubygems_version   = '>= 2.4'

  gem.metadata = {
    'source_code' => gem.homepage,
    'bug_tracker' => "#{gem.homepage}/issues"
  }

  gem.add_dependency 'daemons'
  gem.add_dependency 'multi_json', '~>1.0'

  gem.add_development_dependency 'rails', '>=4.0.0'
  gem.add_development_dependency "rake"
  gem.add_development_dependency 'rspec-rails', '~> 3.5', '>= 3.5'
  gem.add_development_dependency 'mocha','~> 1.2', '>= 1.2'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'httpi'

  gem.add_development_dependency 'appraisal', '~> 2.1', '>= 2.1'
  gem.add_development_dependency 'simplecov', '~> 0.12', '>= 0.12'
  gem.add_development_dependency 'simplecov-summary', '~> 0.0.5', '>= 0.0.5'
  gem.add_development_dependency 'coveralls', '~> 0.8', '>= 0.8.17'
  gem.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7'
  gem.add_development_dependency 'inch', '~> 0.7', '>= 0.7.1'
end
