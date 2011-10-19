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
    return redirect_to(domains_path) if user_signed_in? && params[:id] == "home"
    if params[:id] == "contact"
      init = user_signed_in? ? {:name => current_user.name, :email => current_user.email} : {}
      @contact_form = ContactForm.new(init)
    end
    render :template => current_page
  end
  
  def contact
    @contact_form = ContactForm.new(params[:contact_form])
    if !@contact_form.deliver
      render :template => 'pages/contact'
    else
      redirect_to :back, :notice => 'Your notification has been sent!'
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
