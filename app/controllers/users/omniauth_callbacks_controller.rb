class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    oauthorize 'google_oauth2'
  end

  protected

  def oauthorize(provider)
    return redirect_to(:back) if user_signed_in?
    @user = find_or_create_user(provider)
    return redirect_to(:back) unless @user && @user.active_for_authentication?
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: provider.camelcase
    session["devise.google_data"] = env["omniauth.auth"]
    @user.remember_me! if session.delete(:user_remember_me) == "1"
    sign_in_and_redirect @user, event: :authentication
  end

  def find_or_create_user(provider)
    user = if resource then resource
    elsif email then User.where(email: email).first
    elsif uid then Authentication.where(uid: uid).first.try(:user)
    else raise "Bad provider data: #{auth.inspect}"
    end

    if user.nil?
      user = User.new(user_attrs.merge(password: Devise.friendly_token[0,20]))
      user.skip_confirmation!
      user.save!(validate: false)
    end

    authentication = user.authentications.where(provider: provider).first
    if authentication.nil?
      authentication_attrs = authorization_attrs.merge(provider: provider)
      authentication = user.authentications.build(authentication_attrs)
      user.authentications << authentication
    end

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
