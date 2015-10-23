class Domain < ActiveRecord::Base
  self.inheritance_column = :sti_disabled
  nilify_blanks
  include Stampable
  has_paper_trail

  # optional IP for create form, results in a type A record
  attr_accessor :ip
  attr_accessor :domain_ownership_failed

  # attr_accessible :name, :ip, :soa_record, :ns_records, :apply_subdomains

  belongs_to :user, :inverse_of => :domain
  has_many :records, :inverse_of => :domain, :dependent => :destroy
  has_many :permissions, :inverse_of => :domain, :dependent => :destroy
  has_many :permitted_users, :through => :permissions, :source => :user

  cattr_reader :types
  @@types = ['NATIVE', 'MASTER', 'SLAVE', 'SUPERSLAVE']

  has_one :soa_record,
    -> { where(type: 'SOA') },
    :class_name => 'SOA',
    :inverse_of => :domain

  Record.types.each do |type|
    has_many :"#{type.downcase}_records",
      :class_name => type,
      :inverse_of => :domain
    validates_associated :"#{type.downcase}_records"
  end

  validates :name, :presence => true, :uniqueness => true,
    :domainname => {:require_valid_tld => false},
    :exclusion => {:in => BlacklistedDomain}
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
  delegate :domains_exceeding?, :to => :user
  def max_domains_per_user
    if domains_exceeding?
      errors.add :base, <<-DOC
        as a security measure, you cannot have more than
        #{Settings.max_domains_per_user} domains on one account
      DOC
    end
  end

  before_create do
    a_records.build(:content => ip) if ip.present?
  end

  concerned_with :tree_structure, :name_change_subdomains, :name_change_records

  scope :host_domains, -> { where(:name => Settings.host_domains) }

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

  def slave?; self.type == 'SLAVE' end

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

end
