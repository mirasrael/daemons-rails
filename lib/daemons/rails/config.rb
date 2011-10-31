require 'yaml'
require 'erb'

module Daemons
  module Rails
    class Config < Hash
      def new(app_name, configs_path = Rails.root.join("config"))
        config_path = File.join(configs_path, "#{app_name}-daemon.yml")
        config_path = File.join(configs_path, "daemons.yml") unless File.exists?(config_path)
        options = YAML.load(ERB.new(IO.read(config_path)).result)
        options.each { |key, value| self[key.to_sym] = value }
        self[:dir_mode] = self[:dir_mode].to_sym
      end

      def self.[](app_name)
        new(app_name)
      end
    end
  end
end