require 'rails/generators'

module DaemonGenerator
  class DaemonGenerator < Rails::Generators::NamedBase
    namespace 'daemon'
    source_root File.expand_path('../templates', __FILE__)
    argument :daemon_name, :type => :string, :default => "application"

    def generate_daemon
      unless File.exists?(Rails.root.join("script", "daemons"))
        copy_file "daemons", "script/daemons"
        chmod 'script/daemons', 0755
      end
      template "script.rb", "lib/daemons/#{file_name}.rb"
      chmod "lib/daemons/#{file_name}.rb", 0755

      template "script_ctl", "lib/daemons/#{file_name}_ctl"
      chmod "lib/daemons/#{file_name}_ctl", 0755

      unless File.exists?(Rails.root.join("config", "daemons.yml"))
        copy_file "daemons.yml", "config/daemons.yml"
      end
    end
  end
end