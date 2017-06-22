# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash'

require 'daemons'

require 'fileutils'
require 'yaml'
require 'erb'
require 'pathname'
require 'forwardable'

Gem.find_files('daemons/rails/**/*.rb').each { |path| require path }
