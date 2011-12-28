class PermissionsController < ApplicationController
  active_scaffold :permission do |conf|
    conf.actions.exclude :show
    conf.columns = [:domain, :user, :user_email]
    conf.list.columns = [:domain, :user, :user_email]
    conf.create.columns = [:domain, :user_email]
    conf.update.columns = [:domain, :user_email]
    conf.columns[:user_email].form_ui = :virtual
    conf.columns[:user_email].description = 'user\'s email address, to share with. Ex. jhon.doe@domain.com'
  end
  before_filter :ensure_nested_under_domain
end 