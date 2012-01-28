class User < ActiveRecord::Base
  include SentientUser
  stampable
  
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
  has_many :permissions, :inverse_of => :user, :dependent => :destroy
  has_many :permitted_domains, :through => :permissions, :source => :domain
  
  def name
    full_name.blank? ? email : full_name
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  delegate :can?, :cannot?, :to => :ability
  
  def ability(options = {:reload => false})
    options[:reload] ? _ability : (@ability ||= _ability)
  end
  
  # domains per user limit for DOS protection
  def domains_exceeding?
    domains.count >= Settings.max_domains_per_user.to_i
  end

  protected

  def _ability
    Ability.new(:user => self)
  end

end