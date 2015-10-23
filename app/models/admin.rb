class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  # Called by Devise to see if an user can currently be signed in
  def active_for_authentication?
    active? && super
  end

  # Called by Devise to get the proper error message when an user cannot be signed in
  def inactive_message
    !active? ? :deactivated : super
  end

end
