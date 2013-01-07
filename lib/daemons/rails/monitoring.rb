require "daemons"
require "daemons/rails"
require "daemons/rails/config"
require "daemons/rails/controller"
require "active_support/core_ext/module/delegation.rb"

module Daemons
  module Rails
    class Monitoring
      def self.default
        @default ||= self.new
      end

      def initialize(daemons_path = nil)
        @daemons_path = daemons_path
      end

      singleton_class.delegate :daemons_path=, :daemons_path, :controller, :controllers, :statuses, :start, :stop, :to => :default

      # @deprecate use Daemons::Rails::Monitoring#daemons_path=
      def self.daemons_directory=(value)
        self.daemons_path = value
      end

      # @deprecate use Daemons::Rails::Monitoring#daemons_path
      def self.daemons_directory
        self.daemons_path
      end

      def daemons_path=(value)
        @daemons_path = value
      end

      def daemons_path
        @daemons_path || Daemons::Rails.configuration.daemons_path
      end

      def controller(app_name)
        controllers.find { |controller| controller.app_name == app_name }
      end

      def controllers
        Pathname.glob(daemons_path.join('*_ctl')).map { |path| Daemons::Rails::Controller.new(path) }
      end

      def statuses
        controllers.each_with_object({}) { |controller, statuses| statuses[controller.app_name] = controller.status }
      end

      def start(app_name)
        controller(app_name).start
      end

      def stop(app_name)
        controller(app_name).stop
      end
    end
  end
end