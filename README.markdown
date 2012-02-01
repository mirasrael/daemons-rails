Daemons Rails support (based on http://github.com/dougal/daemon_generator)
================

To get it work just add dependency to this gem in your Gemfile.

## GENERATOR ##

    rails generate daemon <name>

Then insert your code in the lib/daemons/\<name\>.rb stub. All pids and logs will live in the normal log/ folder. This helps to make things Capistrano friendly.

## CONTROL ##

Individual control script:

    ./lib/daemons/<name>_ctl [start|stop|restart|status]
    rake daemon:<name>[:(start|stop|status)]

Examples:

    rake daemon:test - runs lib/daemons/test.rb not daemonized
    rake daemon:test:start - start daemon using lib/daemons/test_ctl start
    rake daemon:test:stop - stop daemon using lib/daemons/test_ctl stop
    rake daemon:test:status - show running status for daemon using lib/daemons/test_ctl status

App-wide control script:
  
    ./script/daemons [start|stop|restart]
    rake daemons:(start|stop|status)

## MONITORING API ##

    Daemons::Rails::Monitoring.statuses - hash with all daemons and corresponding statuses
    Daemons::Rails::Monitoring.start("test.rb") - start daemon using lib/daemons/test_ctl start
    Daemons::Rails::Monitoring.stop("test.rb") - start daemon using lib/daemons/test_ctl stop
    Daemons::Rails::Monitoring.controllers - list of controllers
    Daemons::Rails::Monitoring.controller("test.rb") - controller for test.rb application
  
    controller = Daemons::Rails::Monitoring.controller("test.rb")
    controller.path # => lib/daemons/test_ctl
    controller.app_name # => test.rb
    controller.start # => starts daemon
    controller.stop # => stops daemon
    controller.status # => :not_exists or :running

## CHANGES ##

* 1.0.0 - changed api for Daemons::Rails::Monitoring, fixed path in template for script, improved documentation, added RSpec
* 0.0.3 - added rake for running script without daemonization (rake daemon:\<name\>)