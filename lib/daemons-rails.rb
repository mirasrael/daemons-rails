module Daemons
  class Railtie < Rails::Railtie
    generators do
      require "generators/daemon_generator.rb"
    end
  end
end
