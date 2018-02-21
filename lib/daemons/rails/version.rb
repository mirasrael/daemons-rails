#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true
module Daemons
  # Returns the version of the gem  as a <tt>Gem::Version</tt>
  module Rails
    #  it prints the gem version as a string
    #
    # @return [String]
    #
    # @api public
    def self.gem_version
      Gem::Version.new VERSION::STRING
    end

    # module used to generate the version string
    # provides a easy way of getting the major, minor and tiny
    module VERSION
      # major release version
      MAJOR = 1
      # minor release version
      MINOR = 2
      # tiny release version
      TINY = 1
      # prelease version ( set this only if it is a prelease)
      PRE = nil

      # generates the version string
      STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
    end
  end
end
