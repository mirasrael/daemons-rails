#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true
require_relative './core'
require_relative './controller_command'
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
        argv.each { |key, value| arguments += "--#{key}=#{value} " }
        daemon_script = "bundle exec ruby #{path} #{command} #{arguments unless argv.empty?}"
        runner = ::Daemons::Rails::ControllerCommand.new(self)
        runner.execute(daemon_script)
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
        status = run('status', argv).to_s.chomp
        match_data = status =~ /running\s+\[pid\s+\d+\]/
        match_data ? :running : :not_exists
      end

      def restart?(argv = {})
        status(argv) != :running
      end

      def restart_if_needed(argv = {})
        run('start', argv) if restart?(argv)
      end

      private

      def default_env
        (::ENV['RAILS_ENV'] || ::ENV['RACK_ENV'] || ::ENV['APP_ENV'] || 'development').to_s
      end

      def prepare_argv_for_running(argv = {})
        argv = argv.is_a?(Hash) ? argv : {}
        argv = { RAILS_ENV: default_env }.merge(argv)
        argv
      end
    end
  end
end
