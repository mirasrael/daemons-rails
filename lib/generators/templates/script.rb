#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
$reload = false
Signal.trap("TERM") do
  $running = false
end

Signal.trap("SIGHUP") do
  $reload = true
end

$stdin.sync = true if $stdin.isatty
$stdout.sync = true if $stdout.isatty
$stderr.sync = true if $stderr.isatty

Rails.logger.auto_flushing = true if Rails.logger.respond_to?(:auto_flushing)

while ($running) do
  # Replace this with your code
  Rails.logger.info "This daemon is still running at #{Time.now} -- #{ENV['RAILS_ENV']} -- #{ENV['RACK_ENV']} -- #{Rails.env}.\n"

  sleep 10
end
