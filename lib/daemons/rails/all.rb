#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: UTF-8

# warn_indent: true
require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'fileutils'
require 'yaml'
require 'erb'
require 'pathname'
require 'forwardable'

require 'active_support/all'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/starts_ends_with'

require 'daemons'

require_relative './core'

if defined?(::Rails)
  require 'active_support/railtie'
  require 'rails'
  require 'rails/railtie'
  require 'action_dispatch/railtie'
  require 'rails/engine'
  require_relative './engine'
end

Dir.glob(File.join(::Daemons::Rails.root, 'lib', 'daemons' ,'rails', '**','**', '*.rb')).each do |path|
  require(path) unless %w(all.rb engine.rb).include?(File.basename(path))
end