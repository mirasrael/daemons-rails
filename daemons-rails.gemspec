# -*- encoding: utf-8 -*-
require File.expand_path('../lib/daemons/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mirasrael"]
  gem.email         = []
  gem.description   = %q{daemons gem support for Rails 3}
  gem.summary       = %q{daemons gem support for Rails 3}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "daemons-rails"
  gem.require_paths = ["lib"]
  gem.version       = Daemons::Rails::VERSION

  gem.add_dependency 'daemons'
  gem.add_dependency 'multi_json', '~>1.0'

  gem.add_development_dependency 'rails', '>=3.0.0'
  gem.add_development_dependency "rake"
  gem.add_development_dependency 'rspec', '>=2.12'
end
