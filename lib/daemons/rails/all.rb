require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'daemons'

require 'fileutils'
require 'yaml'
require 'erb'
require 'pathname'
require 'forwardable'

Gem.find_files('daemons/rails/**/*.rb').each { |path| require path }
