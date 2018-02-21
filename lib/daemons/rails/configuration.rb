#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true

require_relative './configuration_helper'
module Daemons
  module Rails
    class Configuration
      include Daemons::Rails::ConfigurationHelper

      def detect_root
        if ENV['DAEMONS_ROOT']
          Pathname.new(ENV['DAEMONS_ROOT'])
        elsif defined?(::Rails)
          ::Rails.root
        else
          root = try_detect_file
          fail_rails_not_found(root)
          root
        end
      end

      def detect_bundle_gemfile
        try_detect_file('Gemfile')
      end

      def daemons_path=(path)
        @daemons_path = path && (path.is_a?(Pathname) ? path : Pathname.new(File.expand_path(path)))
      end

      def app_root=(path)
        @root = path && (path.is_a?(Pathname) ? path : Pathname.new(File.expand_path(path)))
      end

      def app_root
        @root || detect_root
      end

      def daemons_path
        @daemons_path || app_root.join('lib', 'daemons')
      end

      def daemons_directory
        daemons_path.relative_path_from(app_root)
      end
    end
  end
end
