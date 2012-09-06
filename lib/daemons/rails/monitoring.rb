require "daemons"
require "daemons/rails"
require "daemons/rails/config"
require "daemons/rails/controller"
require "active_support/core_ext/module/delegation.rb"

module Daemons
  module Rails
    class Monitoring
      attr_accessor :daemons_directory

      def self.default
        @default ||= self.new
      end

      def initialize(daemons_directory = Daemons::Rails.configuration.daemons_path)
        @daemons_directory = daemons_directory
      end

      singleton_class.delegate :daemons_directory=, :daemons_directory, :controller, :controllers, :statuses, :start, :stop, :to => :default

      def daemons_directory=(value)
        self.default.daemons_directory = value
      end

      def daemons_directory
        @daemons_directory || Daemons::Rails.configuration.daemons_path
      end

      def controller(app_name)
        controllers.find { |controller| controller.app_name == app_name }
      end

      def controllers
        Pathname.glob(daemons_directory.join('*_ctl')).map { |path| Daemons::Rails::Controller.new(path) }
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