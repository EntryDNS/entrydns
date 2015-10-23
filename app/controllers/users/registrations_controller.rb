class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource_or_scope)
    page_path('notice')
  end
end
