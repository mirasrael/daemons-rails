require "daemons"
require "daemons/rails"
require "daemons/rails/config"
require "daemons/rails/controller"

module Daemons
  module Rails
    class Monitoring
      def self.daemons_directory=(value)
        @daemons_directory = value
      end

      def self.daemons_directory
        @daemons_directory || Daemons::Rails.configuration.daemons_directory
      end

      def self.controller(app_name)
        controllers.find { |controller| controller.app_name == app_name }
      end

      def self.controllers
        Pathname.glob(daemons_directory.join('*_ctl')).map { |path| Daemons::Rails::Controller.new(path) }
      end

      def self.statuses
        controllers.each_with_object({}) { |controller, statuses| statuses[controller.app_name] = controller.status }
      end

      def self.start(app_name)
        controller(app_name).start
      end

      def self.stop(app_name)
        controller(app_name).stop
      end
    end
  end
end