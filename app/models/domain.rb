class Domain < ActiveRecord::Base
  self.inheritance_column = "sti_disabled"
  nilify_blanks
  stampable

  # optional IP for create form, results in a type A record
  attr_accessor :ip
  attr_accessor :domain_ownership_failed
  
  belongs_to :user, :inverse_of => :domain
  has_many :records, :inverse_of => :domain, :dependent => :destroy
  has_many :permissions, :inverse_of => :domain, :dependent => :destroy
  has_many :permitted_users, :through => :permissions, :source => :user

  cattr_reader :types
  @@types = ['NATIVE', 'MASTER', 'SLAVE', 'SUPERSLAVE']
  
  has_one :soa_record,
    :class_name => 'SOA', 
    :conditions => {:type => 'SOA'},
    :inverse_of => :domain
  
  for type in Record.types
    has_many :"#{type.downcase}_records", 
      :class_name => type, 
      :conditions => {:type => type},
      :inverse_of => :domain
    validates_associated :"#{type.downcase}_records"
  end
  
  validates :name, :presence => true, :uniqueness => true, :domainname => {:require_valid_tld => false}
  validates :master, :presence => true, :if => :slave?
  validates :master, :ip => true, :allow_nil => true, :if => :slave?
  validates :type, :inclusion => { :in => @@types, :message => "Unknown domain type" }
  validates :soa_record, :presence => {:unless => :slave?}
  validates_associated :soa_record #, :allow_nil => true
  validates :ns_records, :on => :create, :presence => true, :length => {
    :minimum => 2, :maximum => 10, :message => "must have be at least 2, at most 10"}
  validates_associated :records
  validates :user_id, :presence => true
  
  validate :max_domains_per_user, :on => :create
  def max_domains_per_user
    if domains_exceeding?
      errors.add :base, "as a security measure, you cannot have more than #{Settings.max_domains_per_user} domains on one account"
    end
  end
  
  delegate :domains_exceeding?, :to => :user

  validate :domain_ownership
  def domain_ownership
    # non-TLD validation
    errors[:name] = "cannot be a TLD or a reserved domain" if Tld.include?(name)

    # If parent domain is on our system, the user be permitted to manage current domain.
    # He either owns parent, or is permitted to current domain or to an ancestor.
    if parent_domain.present? && !parent_domain.can_be_managed_by_current_user?
      @domain_ownership_failed = true
      errors[:name] = "issue, the parent domain `#{parent_domain.name}` is registered to another user"
    end
  end
  
  # Returns the first immediate parent, if exists (and caches the search)
  def parent_domain
    return nil if name.nil?
    @parent_domain ||= {}
    @parent_domain[name] ||= _parent_domain
  end
  
  # If current user present authorize it
  # If current user not present, just allow (rake tasks etc)
  def can_be_managed_by_current_user?
    return true if User.current.nil?
    Ability::CRUD.all?{|operation| User.current.can?(operation, self)}
  end
  
  def slave?; self.type == 'SLAVE' end

  before_create do
    a_records.build(:content => ip) if ip.present?
  end
  
  before_save do
    self.name_reversed = name.reverse if name_changed?
  end
  
  before_validation(:on => :update) do
    if name_changed?
      name_was_pattern = /#{Regexp.escape(name_was)}$/
      each_update_involved_record do |record|
        if record.type == 'SOA'
          record.reset_serial
          record.name = name
        else
          record.name = record.name.sub(name_was_pattern, name)
        end
        record.domain = self
      end
    end
  end

  after_update do
    if name_changed?
      name_was_pattern = /#{Regexp.escape(name_was)}$/
      records.each do |record|
        record.name = record.name.sub(name_was_pattern, name)
        record.save!
      end
    end
  end
  
  def each_update_involved_record
    yield soa_record
    soa_records.each { |record| yield record }
    records.each     { |record| yield record }
  end

  scope :host_domains, where(:name => Settings.host_domains)
  
  def subdomains
    Domain.where(:name_reversed.matches => "#{name_reversed}.%")
  end
  
  def host_domain?
    Settings.host_domains.include?(name)
  end
  
  # domains per user limit for DOS protection
  def records_exceeding?
    records.count >= Settings.max_records_per_domain.to_i
  end
  
  # domain.has_ns?('129.168.0.1')
  def has_ns?(ns)
    ns_records.any? {|ns_record| ns_record.content == ns}
  end
  
  def setup(email)
    build_soa_record
    soa = soa_record
    soa.contact ||= email

    ns_records.build
    ns_records.build
    ns_records.build
    ns1, ns2, ns3 = ns_records
    ns1.content = Settings.ns.first
    ns2.content = Settings.ns.second
    ns3.content = Settings.ns.third
  end
  
  protected
  
  # Returns the first immediate parent, if exists (does not cache the search)
  # For example "sub.sub.domain.com"'s parent might be "sub.domain.com" or "domain.com"
  def _parent_domain
    segments = name.split('.')
    while segments.size > 1
      segments.shift
      domain = Domain.find_by_name(segments.join('.'))
      return domain if domain.present?
    end
    return nil
  end
  
end
