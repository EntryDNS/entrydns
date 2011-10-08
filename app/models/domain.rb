class Domain < ActiveRecord::Base
  set_inheritance_column "sti_disabled"
  nilify_blanks

  # optional IP for create form, results in a type A record
  attr_accessor :ip
  
  belongs_to :user
  has_many :records, :dependent => :destroy, :inverse_of => :domain

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
  validates_associated :soa_record, :allow_nil => true
  validates :ns_records, :presence => true, :length => {
    :minimum => 2, :maximum => 10,
    :message => "must have be at least 2, at most 10"}
  validates_associated :records
  
  def slave?; self.type == 'SLAVE' end

  before_create do
    a_records.build(:content => ip) if ip.present?
  end
  
  before_validation(:on => :update) do
    if name_changed?
      soa_record.reset_serial
      # soa_record.name = soa_record.name.gsub(/#{name_was}$/, name)
      for record in records
        record.name = record.name.gsub(/#{name_was}$/, name)
      end
    end
  end
  
  def setup(email)
    build_soa_record
    soa = soa_record
    soa.contact ||= email

    ns_records.build
    ns_records.build    
    ns1, ns2 = ns_records
    ns1.content = Settings.ns.first
    ns2.content = (Settings.ns - [ns1.content]).sample
  end
end
