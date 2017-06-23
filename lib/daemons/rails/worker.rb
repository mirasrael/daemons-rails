require_relative "./helper.rb"
module Daemons
  module Rails
    class Worker
      include Daemons::Rails::Helper

      attr_accessor :controller_path, :argv,:options, :config, :dir, :log_dir, :log_base_name

      def initialize(controller_path, argv = [], options = {})
        self.controller_path = File.expand_path(controller_path)
        self.argv = argv.is_a?(Array) ? argv : []
        self.options = options.is_a?(Hash) ? options : {}
        self.config = config.merge(@options)
      end

      def config
        @config||= ::Daemons::Rails::Config.for_controller(@controller_path)
        @config[:ARGV] = @config[:ARGV] || argv
        @config
      end

      def run
        check_directory_given
        check_logging_enabled
        prepare_directories
        prepare_logging_if_needed
        start_work
      end

      private

      def check_directory_given
        if string_blank?(config[:dir])
          raise "Please make sure you have the :dir option set in your configuration file"
        else
          self.dir = ::Daemons::Pid.dir(config[:dir_mode], config[:dir], @controller_path)
        end
      end


      def check_logging_enabled
        return if string_blank?(config[:log_dir]) || config[:log_output].to_s != "true"
        config_logdir = config[:log_dir] or config[:dir_mode] == :system ? '/var/log' : @dir
        self.log_dir = config[:log_dir] = File.expand_path(config_logdir)
      end

      def prepare_logging_if_needed
        return if string_blank?(@log_dir)

        config[:output_logfilename] = config[:output_logfilename] || "#{File.basename(@controller_path)}.rb.txt"
        config[:logfilename] = config[:logfilename] || "#{File.basename(@controller_path)}.rb.log"

        [config[:logfilename], config[:output_logfilename]].each do |file|
          FileUtils.touch(file) unless File.exist?(file)
        end
      end

      def prepare_directories
        [@dir, @log_dir].each do |directory|
          FileUtils.mkdir_p(directory) if !directory.nil? && !File.directory?(directory)
        end
      end

      def start_work
        ::Daemons.run(config[:script], config.to_hash)
      end

    end
  end
end
