class User < ActiveRecord::Base
  include SentientModel
  model_stamper
  stampable
  audited
  
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
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :first_name, :last_name
  
  has_many :domains, :inverse_of => :user, :dependent => :destroy
  has_many :records, :inverse_of => :user, :dependent => :destroy
  has_many :permissions, :inverse_of => :user, :dependent => :destroy
  has_many :permitted_domains, :through => :permissions, :source => :domain
  has_many :audits, :as => :auditable
  
  def name
    full_name.blank? ? email : full_name
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # domains per user limit for DOS protection
  def domains_exceeding?
    domains.count >= Settings.max_domains_per_user.to_i
  end
  
  # Called by Devise to see if an user can currently be signed in
  def active_for_authentication?
    active? && super
  end

  # Called by Devise to get the proper error message when an user cannot be signed in
  def inactive_message
    !active? ? :deactivated : super
  end
  
  delegate :can?, :cannot?, :to => :ability
  
  def ability(options = {:reload => false})
    options[:reload] ? _ability : (@ability ||= _ability)
  end
  
  def self.do_as(user)
    self.current = user
    self.stamper = user
    yield
    self.current = nil
    self.reset_stamper
  end
  
  protected

  def _ability
    UserAbility.new(self)
  end

end