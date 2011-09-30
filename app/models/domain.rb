class Domain < ActiveRecord::Base
  set_inheritance_column "sti_disabled"
  nilify_blanks
  
  belongs_to :user
  has_many :records, :dependent => :destroy

  cattr_reader :types
  @@types = ['NATIVE', 'MASTER', 'SLAVE', 'SUPERSLAVE']
  
  has_one :soa_record, :class_name => 'SOA', :conditions => {:type => 'SOA'}
  
  for type in Record.types
    has_many :"#{type.downcase}_records", :class_name => type, :conditions => {:type => type}
    validates_associated :"#{type.downcase}_records"
  end
  
  validates :name, :presence => true, :uniqueness => true, :domainname => {:require_valid_tld => false}
  validates :master, :presence => true, :if => :slave?
  validates :master, :ip => true, :allow_nil => true, :if => :slave?
  validates :type, :inclusion => { :in => @@types, :message => "Unknown domain type" }
  validates :soa_record, :presence => {:unless => :slave?}
  validates_associated :soa_record, :allow_nil => true
  validates :ns_records, :presence => true, :length => {:minimum => 2, :message => "must have be at least 2"}
  validates_associated :records
  
  def slave?; self.type == 'SLAVE' end
end
