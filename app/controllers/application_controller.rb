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
    @client_remote_ip ||= Settings.uses_proxy ? request.remote_ip : request.ip
  end

  def check_honeypot
    render :nothing => true if params[Settings.honeypot].present?
  end

  def after_sign_out_path_for(resource_or_scope)
    page_path('signed_out')
  end

  def current_ability
    @current_ability ||= ::UserAbility.new(current_user)
  end

  class UserParameterSanitizer < Devise::ParameterSanitizer

    def sign_up
      default_params.permit(:full_name, :email, :password)
    end

    def account_update
      default_params.permit(:full_name, :email, :password, :current_password)
    end

  end

  def devise_parameter_sanitizer
    super unless resource_class == User
    UserParameterSanitizer.new(User, :user, params)
  end

  def user_for_paper_trail
    if user_signed_in?
      current_user.to_paper_trail
    else
      "Public ip:#{client_remote_ip}"
    end
  end

end
