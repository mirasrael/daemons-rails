require "daemons"

module Daemons
  module Rails
    class Monitoring
      def self.daemons_directory=(value)
        @daemons_directory = value
      end

      def self.daemons_directory
        @daemons_directory ||= ::Rails.root.join('lib', 'daemons')
      end

      def self.application(app_name)
        group(app_name).applications.first
      end

      # We do not cache group to be sure we have actual information about running applications
      def self.group(app_name)
        app_config = Daemons::Rails::Config.new(app_name, ::Rails.root)
        group = Daemons::ApplicationGroup.new("#{app_name}.rb", app_config.to_hash)
        group.setup
        group
      end

      def self.groups
        groups = []
        daemons_directory.each_entry do |file|
          if !file.directory? && file.basename.to_s =~ /(\w+)_ctl/
            groups << group($1)
          end
        end
        groups
      end

      def self.status
        groups.each_with_object({}) do |group, statuses|
          app = group.applications.first
          statuses[group.app_name.sub(/\.rb$/, "")] = app && app.running? ? :running : :not_exists
        end
      end
    end
  end
end