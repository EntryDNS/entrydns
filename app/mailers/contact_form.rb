class ContactForm < MailForm::Base
  attribute :name, :validate => true
  attribute :email, :validate => true
  attribute :message, :validate => true
  attribute :file, :attachment => true, :allow_blank => true
  attribute :nickname, :captcha  => true # antispam

  validates :email, email: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "#{name} Contact Form",
      :to => Settings.support_mail,
      :from => %("#{name}" <#{email}>)
    }
  end
end
