class User < ActiveRecord::Base
  include SentientModel
  include Stampable
  has_paper_trail

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :confirmable,
    :lockable,
    :omniauthable,
    :omniauth_providers => [:google_oauth2]

  validates :full_name, :presence => true

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me,
  #   :full_name

  has_many :authentications, :inverse_of => :user, :dependent => :destroy
  has_many :domains, :inverse_of => :user, :dependent => :destroy
  has_many :records, :inverse_of => :user, :dependent => :destroy
  has_many :permissions, :inverse_of => :user, :dependent => :destroy
  has_many :permitted_domains, :through => :permissions, :source => :domain

  def name
    full_name.blank? ? email : full_name
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

  def ban!
    self.class.transaction do
      update_column :active, false
      domains.each &:destroy
      records.each &:destroy
      permissions.each &:destroy
    end
  end

  def unban!
    update_column :active, true
  end

  def to_paper_trail
    "#{id} #{email} name:#{full_name} ip:#{current_sign_in_ip} last_ip:#{last_sign_in_ip}"
  end

  # @override
  def update_tracked_fields!(*)
    self.paper_trail_event = "sign_in"
    PaperTrail.whodunnit = to_paper_trail
    super
  end

  delegate :can?, :cannot?, :to => :ability

  def ability(options = {:reload => false})
    options[:reload] ? _ability : (@ability ||= _ability)
  end

  def self.do_as(user)
    self.current = user
    yield
    self.current = nil
  end

  protected

  def _ability
    UserAbility.new(self)
  end

end
