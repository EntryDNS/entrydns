class Users::PermissionMailer < ActionMailer::Base
  layout "emails"
  default from: Settings.support_mail

  def created(permission)
    @permission = permission
    mail(
      :to => permission.user.email,
      :subject => "#{permission.domain.name} was shared with you to administer"
    )
  end

  def destroyed(permission)
    @permission = permission
    mail(
      :to => permission.user.email,
      :subject => "#{permission.domain.name} is no longer shared with you"
    )
  end
end
