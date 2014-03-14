module Daemons
  module Rails
    class Controller
      attr_reader :path, :app_name

      def initialize(controller_path)
        @path = controller_path
        @app_name = "#{controller_path.basename.to_s[0...-'_ctl'.length]}.rb"
      end

      def run(command, argv={})
        arguments = '-- '
        argv.each {|key,value| arguments += "#{key} #{value} "}
        `cd #{Daemons::Rails.configuration.root} && #{path} #{command} #{arguments unless argv.empty?}`
      end

      def start(argv={})
        run('start',argv)
      end

      def stop
        run('stop')
      end

      def status
        run('status').to_s.split("\n").last =~ /: running \[pid \d+\]$/ ? :running : :not_exists
      end
    end
  end
end
