#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true

require_relative './configuration'
require_relative './worker'
module Daemons
  module Rails
    # class methods
    class << self
      # @return [Daemons::Rails::Configuration]
      def configuration
        @configuration ||= ::Daemons::Rails::Configuration.new
      end

      def configure
        yield configuration
      end

      def root
        ::File.expand_path(::File.dirname(::File.dirname(::File.dirname(__dir__))))
      end

      def run(*args)
        ::Daemons::Rails::Worker.new(*args).run
      end
    end
  end
end