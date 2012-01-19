require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'cancan/matchers'
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
end

Spork.each_run do
  require 'simplecov'
  SimpleCov.start 'rails'
  FactoryGirl.reload
end
