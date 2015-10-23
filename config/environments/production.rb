Entrydns::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  db_operation = File.basename($0) == "rake" &&
    %w(db:migrate db:schema:load).any? { |op| op.in?(ARGV) }

  # Code is not reloaded between requests, unless rake
  # https://github.com/activescaffold/active_scaffold/issues/131
  config.cache_classes = !db_operation
  config.eager_load = !db_operation

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  config.cache_store = :dalli_store, 'localhost', {
    :memcache_server => ['127.0.0.1'],
    :namespace => 'entrydns',
    :expires_in => 1.day,
    :compress => true
  }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
    :access_key_id     => Settings.ses_access_key_id,
    :secret_access_key => Settings.ses_secret_access_key
  config.action_mailer.default_url_options = {:host => 'entrydns.net'}
  #  config.action_mailer.delivery_method = :smtp
  #  config.action_mailer.smtp_settings = {
  #    :address => "127.0.0.1",
  #    :port    => 25,
  #    :domain  => 'entrydns.net'
  #  }
  config.action_mailer.delivery_method = :ses

  # Compress JavaScripts and CSS
  config.assets.js_compressor = :uglifier

  # disable paper-trail in production
  config.after_initialize do
    PaperTrail.enabled = false
  end
end
