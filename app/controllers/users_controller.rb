class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user_current
  after_filter :unset_user_current
  layout :scoped_layout

  rescue_from CanCan::AccessDenied, ActiveScaffold::ActionNotAllowed do |exception|
    flash.now[:error] = exception.message
    render_access_denied
  end

  protected

  def set_user_current
    User.current = current_user
  end

  def unset_user_current
    User.current = nil
  end

  def ensure_nested_under_domain
    unless nested? && nested_parent_record.is_a?(Domain)
      raise CanCan::AccessDenied, "not found"
    end
  end

end
