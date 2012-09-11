class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_stampers
  include Userstamp
  layout :scoped_layout

  rescue_from CanCan::AccessDenied, ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = exception.message
    render_access_denied
  end

  protected
  
  def set_stampers
    User.current = current_user
    User.stamper = current_user
  end

  def ensure_nested_under_domain
    unless nested? && nested_parent_record.is_a?(Domain)
      raise CanCan::AccessDenied, "not found"
    end
  end

end
