class PermissionsController < ApplicationController
  active_scaffold :permission do |conf|
    conf.actions.exclude :show, :search
    conf.columns = [:domain, :user, :user_email]
    conf.list.columns = [:domain, :user, :user_email]
    conf.create.columns = [:domain, :user_email]
    conf.update.columns = [:domain, :user_email]
    conf.columns[:user_email].form_ui = :virtual
    conf.columns[:user_email].description = 'user\'s email address, to share with. Ex. jhon.doe@domain.com'
    conf.create.link.label = 'Share Domain'
    # conf.columns[:user_email].search_sql = 'user.email'
    # conf.columns[:user].search_sql = 'CONCAT(first_name, ' ', last_name)'
  end
  before_filter :ensure_nested_under_domain
  
  protected
  
  def beginning_of_chain
    super.readonly(false)
  end
end 