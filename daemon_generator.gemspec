# -*- encoding: utf-8 -*-
require File.expand_path('../lib/daemon_generator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mirasrael"]
  gem.email         = []
  gem.description   = %q{Daemons generator for Rails 3}
  gem.summary       = %q{Daemons generator for Rails 3}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "daemon_generator"
  gem.require_paths = ["lib"]
  gem.version       = DaemonGenerator::VERSION

  gem.add_dependency 'rails', '~>3.0.0'
  gem.add_dependency 'daemons'
  gem.add_dependency 'multi_json', '~>1.0'
  gem.add_development_dependency "rake"
end
