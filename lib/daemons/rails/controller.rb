#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true
module Daemons
  module Rails
    class Controller
      attr_reader :path, :app_name

      def initialize(controller_path)
        @path = controller_path
        @app_name = "#{controller_path.basename.to_s[0...-'_ctl'.length]}.rb"
      end

      def run(command, argv = {})
        arguments = '-- '
        argv = prepare_argv_for_running(argv)
        argv.each { |key, value| arguments += "#{key}=#{value} " }
        `cd "#{::Daemons::Rails.configuration.root}" && "#{path}" #{command} #{arguments unless argv.empty?}`
      end

      def start(argv = {})
        run('start', argv)
      end

      def stop(argv = {})
        run('stop', argv)
      end

      def reload(argv = {})
        run('reload', argv)
      end

      def zap(argv = {})
        run('zap', argv)
      end

      def restart(argv = {})
        run('restart', argv)
      end

      def status(argv = {})
        run('status', argv).to_s.split("\n").last.match?(/: running \[pid \d+\]$/) ? :running : :not_exists
      end

      def restart?(argv = {})
        status(argv) != :running
      end

      def restart_if_needed(argv = {})
        run('start', argv) if restart?(argv)
      end

      def available?(environment)
        daemons_config = ::Daemons::Rails::Config.for_controller(@path)
        daemons_config &&
          daemons_config['available_environments'] &&
          daemons_config['available_environments'].include?(environment)
      end

      private

      def prepare_argv_for_running(argv = {})
        argv = {} unless argv.is_a?(Hash)
        argv = {'RAILS_ENV' => ENV["RAILS_ENV"]}.merge(argv)
        argv
      end
    end
  end
end
