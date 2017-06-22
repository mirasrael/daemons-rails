#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true

require 'daemons/rails/all'

module Daemons
  module Rails
    # @return [Daemons::Rails::Configuration]
    def self.configuration
      @configuration ||= ::Daemons::Rails::Configuration.new
    end

    def self.configure
      yield configuration
    end

    def self.run(*args)
      ::Daemons::Rails::Worker.new(*args).run
    end
  end
end
