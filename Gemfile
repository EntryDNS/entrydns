source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

gem 'devise', '~> 1.4.5'
gem 'cancan', '~> 1.6.5'
#gem "meta_where", "~> 1.0" # squeel ?
gem 'sentient_user', '~> 0.3.2'
gem 'active_scaffold', '~> 3.1.0', :git => 'https://github.com/activescaffold/active_scaffold.git'
gem 'web-app-theme', :git => 'git://github.com/tscolari/web-app-theme.git', :branch => 'v3.1.0'
gem 'pjax_rails', '~> 0.1.10'
gem 'validates_hostname', '~> 1.0.0', :git => 'https://github.com/KimNorgaard/validates_hostname.git'
gem 'nilify_blanks', '~> 1.0.0'
gem 'rails_config', '~> 0.2.4'
# gem 'rails-settings-cached', :require => 'rails-settings'
gem 'capistrano', '~> 2.9.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'compass', '~> 0.12.alpha.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
  gem 'therubyracer'
end

gem 'jquery-rails'
# gem 'foreigner' ?

gem 'rspec-rails', '~> 2.6.1', :group => [:test, :development]
group :test do
  gem 'factory_girl_rails', '~> 1.2'
  gem 'capybara', '~> 1.1.1'
  gem 'spork', '~> 0.9.0.rc'
end
