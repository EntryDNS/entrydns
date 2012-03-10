class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  include SentientController
  protect_from_forgery
  before_filter :check_honeypot
  helper_method :client_remote_ip, :respond_to
  
  rescue_from CanCan::AccessDenied, ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = exception.message
    render_access_denied
  end

  rescue_from ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = I18n.t("errors.action_not_allowed")
    render_access_denied
  end
  
  protected
  
  def render_access_denied
    layout = request.xhr? ? false : 'errors'
    render :template => 'errors/access_denied', :layout => layout
  end
  
  def ensure_nested_under_domain
    raise CanCan::AccessDenied, "not found" unless nested? and nested_parent_record.is_a?(Domain)
  end
  
  def client_remote_ip
    @client_remote_ip ||= request.env["HTTP_X_FORWARDED_FOR"]
  end
  
  def check_honeypot
    render :nothing => true if params[Settings.honeypot].present?
  end
  
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    page_path('signed_out')
  end
  
end
