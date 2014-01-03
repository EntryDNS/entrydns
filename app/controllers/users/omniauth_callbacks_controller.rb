class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_apps
    oauthorize 'google_apps'
  end

  protected

  def oauthorize(provider)
    @user = find_for_oauth(provider)
    return unless @user
    if @user.active_for_authentication?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: provider.camelcase
      session["devise.google_apps_data"] = env["omniauth.auth"]
      @user.remember_me! if session.delete(:user_remember_me) == "1"
    end
    if user_signed_in?
      redirect_to :back
    else
      sign_in_and_redirect @user, event: :authentication
    end
  end
  
  def find_for_oauth(provider)
    user = if resource then resource
    elsif email then find_or_create_by_email(email)
    elsif uid then find_or_create_by_uid(uid)
    else raise "Bad provider data: #{auth.inspect}"
    end
    
    authentication = user.authentications.where(provider: provider).first
    if authentication.nil?
      authentication_attrs = authorization_attrs.merge(provider: provider)
      authentication = user.authentications.build(authentication_attrs)
      user.authentications << authentication
    end
    
    return user
  end

  def find_or_create_by_uid(uid)
    auth = Authentication.where(uid: uid).first
    return auth ? auth.user : make_user
  end

  def find_or_create_by_email(email)
    user = User.where(email: email).first
    return user ? user : make_user
  end
  
  def make_user
    return current_user if user_signed_in?
    user = User.new(user_attrs.merge(password: Devise.friendly_token[0,20]))
    user.skip_confirmation!
    user.save!(validate: false)
    return user
  end
  
  def auth; env["omniauth.auth"] end
  def uid; @uid ||= auth['uid'] rescue nil end
  def email; @email ||= auth['info']['email'] rescue nil end
  
  def authorization_attrs
    @authorization_attrs ||= {
      uid: uid,
      token: auth['credentials']['token'],
      secret: auth['credentials']['secret'],
      name: auth['info']['name']
    }
  end
  
  def user_attrs
    @user_attrs ||= { email: email, full_name: auth['info']['name'] }
  end
  
  def handle_unverified_request; true end

end
