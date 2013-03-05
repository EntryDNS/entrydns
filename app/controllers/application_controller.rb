class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_honeypot
  around_filter :set_timezone
  helper_method :client_remote_ip
  layout :scoped_layout
  
  rescue_from ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = I18n.t("errors.action_not_allowed")
    render_access_denied
  end
  
  protected
  
  def set_timezone
    old_time_zone = Time.zone
    Time.zone = cookies[:time_zone] if cookies[:time_zone].present?
    yield
  ensure
    Time.zone = old_time_zone
  end
  
  def scoped_layout
    return false if request.xhr?
    return 'admin' if devise_controller? && resource_name == :admin
    user_signed_in? ? 'users' : 'public'
  end
    
  def render_access_denied
    layout = request.xhr? ? false : 'errors'
    render :template => 'errors/access_denied', :layout => layout
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
  
  def current_ability
    @current_ability ||= ::UserAbility.new(current_user)
  end
  
end
