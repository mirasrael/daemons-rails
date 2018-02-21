module Daemons
  module Rails
    module ConfigurationHelper

      module_function

      def pathname_is_root?(root)
        root.is_a?(::Pathname) && root.root?
      end

      def fail_rails_not_found(root)
        raise "Can't detect Rails application root" if root.blank?
      end

      def pwd_parent_dir
        pwd_directory.directory? ? pwd_directory : pwd_directory.parent
      end

      def pwd_directory
        ::Pathname.new(::FileUtils.pwd)
      end

      def try_detect_file(filename = 'config.ru', root = pwd_parent_dir )
        while (file = find_file_in_directory(root, filename)).blank?
          root = root.parent
        end
        root = root.to_s != file.parent.to_s ? file.parent : root
        pathname_is_root?(root) ? nil : root
      end

      def find_file_in_directory(root, filename)
        file = ::Dir.glob(::File.join(root, '**', filename)).last
        file.nil? ? nil : ::Pathname.new(file)
      end
    end
  end
end