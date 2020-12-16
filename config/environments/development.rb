Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

  #set queue adapter for delayed jobs
  # config.active_job.queue_adapter = :delayed_job

  #show additional error messages raised in callbacks
  # config.active_record.raise_in_transactional_callbacks = true

  config.hosts << "sledding.granlibakken.com"
  config.hosts << "tickets.granlibakken.com"
  config.hosts << "tickets-granlibakken.herokuapp.com"

  config.cache_classes = false

  # DEBUGGING DEC2020 - load CSS changes in local server
  # config.assets.debug = true
  # config.assets.initialize_on_precompile = false


  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true


  if Rails.root.join('tmp/caching-dev.txt').exist?
     config.action_controller.perform_caching = true
     config.cache_store = :memory_store
     config.public_file_server.headers = {
       'Cache-Control' => 'public, max-age=172800'
     }
  else
     config.action_controller.perform_caching = false

     config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  # changed from true to false 11.18.20 for troubleshooting
  # changed back from false to true 12.16.20 to allow local CSS changes to be pushed; also removed assets in public/assets folder; took ~2min to load first time after
  # this should be toggled true when doing local testing and updating .JS or .CSS assets
  config.assets.debug = true
  # config.assets.debug = true
  config.assets.js_compressor = Uglifier.new(harmony: true)

  #Suppress logger output for asset requests
  config.assets.quiet = true
  #GMAIL CONFIG
  config.action_mailer.default_url_options = { :host => ENV['HOST_DOMAIN'] }
  config.action_mailer.delivery_method = :smtp
  #during dev testing, uncomment the ENV variable below to disable Twilio messages
  ENV['twilio_status'] = "inactive"
  # config.action_mailer.perform_deliveries = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "sledding.granlibakken.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "brian@snowschoolers.com",
    password: ENV["GMAIL_PASSWORD"]
  }
  #PAPERCLIP AWS S3 CONFIG
  config.paperclip_defaults = {
  :storage => :s3,
  :s3_region => ENV['AWS_REGION'],
  :s3_host_name => 's3.amazonaws.com',
  :bucket => 'snowschoolers'
  }

  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
