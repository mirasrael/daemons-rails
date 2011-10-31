module DaemonGenerator
  class Railtie < Rails::Railtie
    generators do
      require "daemon_generator/daemon_generator.rb"
    end
  end
end