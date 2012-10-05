source 'http://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# gem 'pg'
gem 'mysql2'
gem 'devise', '~> 2.1.0'
gem 'cancan', '= 1.6.7'
gem 'squeel', '~> 1.0.0'
gem 'sentient_model', '~> 1.0.4'
gem 'userstamp', '~> 2.0.2', git: 'https://github.com/delynn/userstamp.git'
gem 'validates_hostname', '~> 1.0.0', git: 'https://github.com/KimNorgaard/validates_hostname.git'
gem 'nilify_blanks', '~> 1.0.0'
gem 'rails_config', '~> 0.2.4'
gem 'active-model-email-validator', '~> 1.0.2'
gem 'mail_form', '~> 1.3.0'
gem 'switch_user', '~> 0.6.0'
gem 'simple_form', '~> 2.0.0'
gem 'concerned_with', '~> 0.1.0'
gem 'navigasmic', '~> 0.5.6', git: 'https://github.com/jejacks0n/navigasmic.git'
gem 'rails-backbone', '~> 0.7.0'
gem 'acts_as_nested_interval', '~> 0.0.7'
# path: '/home/clyfe/dev/acts_as_nested_interval'
# git: 'https://github.com/clyfe/acts_as_nested_interval.git'
gem 'webshims-rails', '~> 0.2'
gem 'font-awesome-sass-rails', '~> 2.0.0.0'
gem 'seedbank', '~> 0.1.3'
gem 'rails_admin', '~> 0.0.5'
gem 'rails-settings-cached', '~> 0.2.2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'compass-rails', '~> 1.0.3'
  gem 'bootstrap-sass', '~> 2.1.0.0'
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'dalli', '~> 1.1.3'
gem 'active_scaffold', '~> 3.2.16'
# git: 'https://github.com/activescaffold/active_scaffold.git'
# path: '/home/clyfe/dev/active_scaffold'
gem 'turbolinks', '~> 0.5.1'
# gem 'foreigner' ?

group :development do
  gem 'capistrano', '~> 2.9.0'
  gem 'capistrano-ext', '~> 1.2.1'
  gem 'mongrel', '>= 1.2.0.pre2'
  gem 'quiet_assets', '~> 1.0.1'
end

group :test, :development do
  gem 'sourcify', '~> 0.6.0.rc1'
  gem 'rspec-rails', '~> 2.10.1'
  gem 'faker','~> 1.0.1'
  gem 'factory_girl_rails', '~> 1.6.0'
end

group :test do
  gem 'capybara', '~> 1.1.1'
  gem 'database_cleaner', '~> 0.7.1'
  gem 'simplecov', :require => false
  gem 'spork', '~> 1.0.0.rc0'
  gem 'rb-inotify', '~> 0.8.8'
  gem 'libnotify', '~> 0.7.2'
  gem 'guard-rspec', '~> 0.6.0'
  gem 'guard-spork', '~> 0.5.1'
end
