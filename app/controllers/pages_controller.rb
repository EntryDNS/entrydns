class PagesController < ApplicationController
  skip_before_filter :authenticate_user!
  layout proc{|controller| request.xhr? ? false : 'marketing'}
  
  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template pages/}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    # redirect_to domains_path if user_signed_in? # for home page only
    render :template => current_page
  end

  protected

  def current_page; "pages/#{clean_path}" end
  def clean_path; Pathname.new("/#{params[:id]}").cleanpath.to_s[1..-1] end
end
