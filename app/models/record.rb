class Record < ActiveRecord::Base
  include Stampable

  belongs_to :domain, :inverse_of => :records
  belongs_to :user, :inverse_of => :records

  cattr_reader :types
  @@types = %w(SOA NS A MX TXT CNAME AAAA SRV)
  # attr_accessible :name, :content, :ttl, :prio

  validates :domain, :name, :presence => true
  validates :type, :inclusion => {:in => @@types, :message => "Unknown record type"}
  validates :content, :uniqueness => {:scope => [:domain_id, :type, :name]}
  # RFC 2181, 8
  validates :ttl, :numericality => {
    # :greater_than_or_equal_to => 0,
    :greater_than_or_equal_to => Settings.min_ttl.to_i,
    :less_than => 2**31,
    :only_integer => true
  }, :allow_blank => true
  validates :authentication_token, :presence => true, :uniqueness => true
  validate :max_records_per_domain, :on => :create
  def max_records_per_domain
    if records_exceeding? && !host_domain?
      errors.add :base, "as a security measure, you cannot have more than #{Settings.max_records_per_domain} records on one domain"
    end
  end

  before_validation :generate_token, :on => :create
  before_validation :prepare_name!
  before_save :update_change_date
  after_save  :update_soa_serial
  after_initialize do
    self.ttl ||= Settings.default_ttl
  end

  # By default records don't support priorities.
  # Those who do can overwrite this in their own classes.
  def supports_priority?; false end

  def shortname; name.gsub(/\.?#{self.domain.name}$/, '') end
  def shortname=(value); self.name = value end

  def to_label; "#{type} #{content}" end

  # Generate a token by looping and ensuring does not already exist.
  # stolen from Devise
  def generate_token
    self.authentication_token = loop do
      token = Devise.friendly_token
      break token unless Record.exists?(authentication_token: token)
    end
  end

  delegate :host_domain?, :records_exceeding?, :to => :domain
  delegate :user, :to => :domain, :prefix => :domain

  protected

  def prepare_name!
    return if domain.nil? or domain.name.blank?
    self.name = domain.name if name.blank? or name == '@'
    self.name << ".#{domain.name}" unless name =~ /#{Regexp.escape(domain.name)}$/
  end

  # Update the change date for automatic serial number generation
  def update_change_date; self.change_date = Time.now.to_i end

  def update_soa_serial #:nodoc:
    unless type == 'SOA' || @serial_updated || domain.slave?
      domain.soa_record.update_serial!
      @serial_updated = true
    end
  end

  def name_equals_domain_name
    errors.add :name, "must be equal to domain's name" unless name == domain.name
  end

end
