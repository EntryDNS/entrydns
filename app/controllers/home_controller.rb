class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  layout proc{|controller| request.xhr? ? false : 'marketing'}
  
  def index
    redirect_to dashboard_path if user_signed_in?
  end
end
