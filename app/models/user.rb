class User < ActiveRecord::Base
  include SentientUser
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
    :registerable,
    :recoverable, 
    :rememberable, 
    :trackable, 
    :validatable,
    :confirmable,
    :lockable
  
  validates :first_name, :last_name, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  has_many :domains, :inverse_of => :user, :dependent => :destroy
  has_many :records, :inverse_of => :user, :dependent => :destroy
  
  def name
    "#{first_name} #{last_name}"
  end
  
end
