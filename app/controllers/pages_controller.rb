class PagesController < ApplicationController
  skip_before_filter :authenticate_user!
  layout proc{|controller| 
    if request.xhr? 
      false 
    elsif user_signed_in?
      'application'
    else
      'public'
    end
  }
  
  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template pages/}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    if user_signed_in? && params[:id] == "home"
      redirect_to domains_path
    else
      render :template => current_page
    end
  end

  protected
  
  def current_page
    @current_page ||= "pages/#{clean_path}"
  end
  
  def clean_path
    Pathname.new("/#{params[:id]}").cleanpath.to_s[1..-1]
  end
  
end
