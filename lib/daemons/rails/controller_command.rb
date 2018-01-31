#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true

module Daemons
  module Rails
    class ControllerCommand

      attr_reader :controller, :tempfile, :app_root_dir, :app_gemfile, :options

      delegate :path,
        :app_name,
        to: :controller

      def initialize(controller, options = {})
        @controller = controller
        @options = options.with_indifferent_access
        @app_root_dir = ::Daemons::Rails.configuration.app_root
        @app_gemfile = ::Daemons::Rails.configuration.detect_bundle_gemfile
      end

      def execute(command)
        real =  "#{check_rvm_loaded} && #{bundle_gemfile_env(app_gemfile)} #{command}"
        get_command_script(real)
      end

      private

      def command_id
        @command_id ||= options.fetch(:id, SecureRandom.uuid)
      end

      def get_command_script(command)
        command = rvm_bash_prefix(command)
        `#{command}`
      end

      def bundle_gemfile_env(gemfile = app_gemfile)
        "BUNDLE_GEMFILE=#{gemfile}/Gemfile"
      end

      def rvm_bin_path
        @rvm_path ||= `which rvm`.to_s.chomp
      end

      def bash_bin_path
        @bash_bin_path ||= `which bash`.to_s.chomp
      end

      def rvm_installed?
        rvm_bin_path.present?
      end

      def create_tempfile_command(output)
        @tempfile = Tempfile.new(%W(daemon-#{command_id}_command_ .rb), encoding: 'utf-8')
        @tempfile.write(output)
        ObjectSpace.undefine_finalizer(@tempfile) # force garbage collector not to remove automatically the file
        @tempfile.close
      end

      def rvm_scripts_path
        File.join(File.dirname(File.dirname(rvm_bin_path)), 'scripts', 'rvm')
      end

      def app_rvmrc_file
        File.join(app_gemfile, '.rvmrc')
      end

      def app_rvmrc_enabled?
        File.exists?(app_rvmrc_file)
      end

      def rvm_enabled_for_app?
        app_rvmrc_enabled? && rvm_installed? && bash_bin_path.present?
      end

      def check_rvm_loaded
        return  "cd #{app_root_dir}" unless rvm_enabled_for_app?
        "source #{rvm_scripts_path} && rvm rvmrc trust #{File.dirname(app_rvmrc_file)} && cd #{app_root_dir} && source #{app_rvmrc_file}"
      end

      def rvm_bash_prefix(command)
        app_rvmrc_enabled? ? "#{bash_bin_path} --login -c '#{command}'" : command
      end
    end
  end
end