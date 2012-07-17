module Daemons
  module Rails
    class Configuration
      def detect_root
        if defined?(::Rails)
          ::Rails.root
        else
          root = Pathname.new(File.expand_path(__FILE__)).parent
          root = root.parent until File.exists?(root.join('config.ru'))
          root
        end
      end

      def daemons_directory=(path)
        @daemons_directory = path && (path.is_a?(Pathname) ? path : Pathname.new(File.expand_path(path)))
      end

      def daemons_directory
        @daemons_directory ||= detect_root.join('lib', 'daemons')
      end
    end
  end
end