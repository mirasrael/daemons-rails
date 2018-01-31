# frozen_string_literal: true

module Daemons
  module Rails
    class Worker
      attr_accessor :controller_path, :argv, :options, :config, :dir, :log_dir,  :env

      def initialize(controller_path, options = {})
        self.controller_path = File.expand_path(controller_path)
        self.options = options.is_a?(Hash) ? options : {}
        self.argv = ARGV.dup
        self.config = default_config.merge(options)
        self.env = fetch_env(config[:ARGV])
      end

      def default_config
        @config ||= ::Daemons::Rails::Config.for_controller(controller_path)
        @config[:ARGV] = @config[:ARGV] || argv
        @config
      end

      def fetch_env(args)
        options = {}
        args.each do |arg|
          if arg =~ /^(\w+)=(.*)$/m
            options[Regexp.last_match(1)] = Regexp.last_match(2)
          end
        end
        options
      end

      def run
        check_directory_given
        prepare_directories
        prepare_logging_if_needed
        start_work
      end

      private

      def check_directory_given
        if config[:dir].blank?
          raise 'Please make sure you have the :dir option set in your configuration file'
        else
          @dir ||= ::Daemons::Pid.dir(config[:dir_mode], config[:dir], controller_path)
          config[:log_dir] = @dir
        end
      end

      def prepare_directories
        return if config[:log_output].to_s != 'true'
        config_logdir = config[:log_dir] || (config[:dir_mode] == :system ? '/var/log' : @dir)
        @log_dir ||= ::Daemons::Pid.dir(config[:dir_mode], config_logdir, controller_path)
        dir_path = File.expand_path(@log_dir)
        config[:log_dir] = dir_path
        FileUtils.mkdir_p(dir_path) unless File.directory?(dir_path)
      end

      def prepare_logging_if_needed
        return if @log_dir.blank?
        config[:output_logfilename] = config[:output_logfilename] || "#{File.basename(controller_path)}.txt"
        config[:logfilename] = config[:logfilename] || "#{File.basename(controller_path)}.log"
        [config[:logfilename], config[:output_logfilename]].each do |file|
          file_path = File.expand_path(File.join(@log_dir, file))
          FileUtils.touch(file_path) unless File.exist?(file_path)
        end
      end

      def can_work?
        config[:available_environments].is_a?(Array) &&
          config[:available_environments].include?(worker_env)
      end

      def worker_env
        (::ENV['RAILS_ENV'] || ::ENV['RACK_ENV'] || ::ENV['APP_ENV'] ||
          env['RAILS_ENV'] || env['RACK_ENV'] || env['APP_ENV'] ||
          'development').to_s
      end

      def start_work
        return unless can_work?
        ::Daemons.run(config[:script], config.to_hash)
      end
    end
  end
end
