#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true
require_relative './core'
module Daemons
  module Rails
    class Config
      def initialize(app_name, root_path, daemons_dir = File.join(::Daemons::Rails.configuration.app_root, 'lib', 'daemons'))
        @options = {}
        config_path = File.join(root_path, 'config', "#{app_name}-daemon.yml")
        config_path = File.join(root_path, 'config', 'daemons.yml') unless File.exist?(config_path)
        options = YAML.safe_load(ERB.new(IO.read(config_path)).result)
        options.each { |key, value| @options[key.to_sym] = value }
        @options[:dir_mode] = @options[:dir_mode].to_sym
        @options[:script] ||= File.join(root_path, daemons_dir, "#{app_name}.rb")
      end

      def self.for_controller(controller_path, root = ::Daemons::Rails.configuration.app_root)
        new(File.basename(controller_path, '_ctl'), root, Pathname.new(controller_path).parent.relative_path_from(root))
      end

      def [](key)
        @options[key]
      end

      def []=(key, value)
        @options[key] = value
      end

      def to_hash
        @options
      end

      def merge(data = {})
        data = data.is_a?(Hash) ? data : {}
        @options = @options.merge(data)
      end
    end
  end
end
