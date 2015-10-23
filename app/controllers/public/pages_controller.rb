class Public::PagesController < PublicController

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template pages/}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    return redirect_to(domains_path) if user_signed_in? && params[:id] == "home"

    options = {template: current_page}
    case params[:id]
    when "contact"
      init = user_signed_in? ? {:name => current_user.name, :email => current_user.email} : {}
      @contact_form = ContactForm.new(init)
    when "home"
      options[:layout] = 'home' unless request.xhr?
    when "signed_out"
      if user_signed_in?
        flash[:warning] = "You are still authenticated"
        redirect_to after_sign_in_path_for(current_user) and return
      end
    end

    render options
  end

  def contact
    @contact_form = ContactForm.new(params[:contact_form])
    if !@contact_form.deliver
      render :template => 'public/pages/contact'
    else
      redirect_to :back, :notice => 'Your notification has been sent!'
    end
  end

  protected

  def current_page
    @current_page ||= "public/pages/#{clean_path}"
  end

  def clean_path
    Pathname.new("/#{params[:id]}").cleanpath.to_s[1..-1]
  end

  def resource; User.new end
  helper_method :resource

  def resource_name; :user end
  helper_method :resource_name

end
