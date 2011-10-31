require "daemons"

module Daemons
  module Rails
    class Monitoring
      def self.daemons_directory=(value)
        @daemons_directory = value
      end

      def self.daemons_directory
        @daemons_directory ||= Rails.root.join('lib', 'daemons')
      end

      def self.status
        statuses = {}
        daemons_directory.each_file_name do |file|
          if file =~ /.*\/(\w+)_ctl\.rb/
            app_name = $1
            group = Daemons::ApplicationGroup.new(app_name, Daemons::Rails::Config[app_name])
            app = group.setup.first
            statuses[app_name] = app && app.running? ? :running : :not_exists
          end
        end
        statuses
      end
    end
  end
end