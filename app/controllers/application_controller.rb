class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  include SentientController
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied, ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = exception.message
    render :template => 'errors/access_denied', :layout => 'errors'
  end

  rescue_from ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = I18n.t("action_not_allowed")
    render :template => 'errors/access_denied', :layout => 'errors'
  end
  
end
