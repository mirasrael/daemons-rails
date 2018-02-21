Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  config.time_zone = 'Central Time (US & Canada)'

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  if config.respond_to?(:public_file_server)
    config.public_file_server.enabled = true
  elsif config.respond_to?(:serve_static_files)
    config.serve_static_files = true
    config.static_cache_control = "public, max-age=3600"
  end

  config.eager_load = true
  config.cache_store = :null_store

  # Show full error reports and disable caching
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = false
  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  config.force_ssl = false

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.

  # Randomize the order test cases are executed.
  config.active_support.test_order = :sorted

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

end
