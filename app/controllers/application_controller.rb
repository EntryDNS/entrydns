class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  include SentientController
  protect_from_forgery
end
