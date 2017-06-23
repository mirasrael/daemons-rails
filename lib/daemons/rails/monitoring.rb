#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true
module Daemons
  module Rails
    class Monitoring
      singleton_class.extend Forwardable
      singleton_class.def_delegators :default, :daemons_path=, :daemons_path, :controller, :controllers, :statuses, :start, :stop

      def self.default
        @default ||= new
      end

      def initialize(daemons_path = nil)
        @daemons_path = daemons_path
      end

      # @deprecate use Daemons::Rails::Monitoring#daemons_path=
      def self.daemons_directory=(value)
        self.daemons_path = value
      end

      # @deprecate use Daemons::Rails::Monitoring#daemons_path
      def self.daemons_directory
        daemons_path
      end

      attr_writer :daemons_path

      def daemons_path
        @daemons_path || ::Daemons::Rails.configuration.daemons_path
      end

      def controller(app_name)
        controllers.find { |controller| controller.app_name == app_name }
      end

      def controllers
        Pathname.glob(daemons_path.join('*_ctl')).map { |path| ::Daemons::Rails::Controller.new(path) }
      end

      def statuses
        controllers.each_with_object({}) { |controller, statuses| statuses[controller.app_name] = controller.status }
      end

      def start(app_name, argv = {})
        controller(app_name).start(argv)
      end

      def status(app_name, argv = {})
        controller(app_name).status(argv)
      end

      def reload(app_name, argv = {})
        controller(app_name).reload(argv)
      end

      def zap(app_name, argv = {})
        controller(app_name).zap(argv)
      end

      def restart(app_name, argv = {})
        controller(app_name).restart(argv)
      end

      def restart_if_needed(app_name, argv = {})
        controller(app_name).restart_if_needed(argv)
      end

      def restart_controller?(app_name, argv = {})
        controller(app_name).restart?(argv)
      end

      def controller_available?(app_name, environment)
        controller(app_name).available?(environment)
      end

      def stop(app_name, argv = {})
        controller(app_name).stop(argv)
      end
    end
  end
end
