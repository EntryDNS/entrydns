# Be sure to restart your server when you modify this file.

require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store :dalli_store,
  :memcache_server => ['127.0.0.1'],
  :namespace => 'entrydns',
  :key => '_entrydns_session',
  :expire_after => 2.hours

# Entrydns::Application.config.session_store :cookie_store, key: '_entrydns_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Entrydns::Application.config.session_store :active_record_store
