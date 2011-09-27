class Record < ActiveRecord::Base
  belongs_to :domain
  
  cattr_reader :types
  @@types = ['SOA', 'NS', 'A', 'MX', 'TXT', 'CNAME']
  
  validates :domain_id, :name, :presence => true
  validates :type, :inclusion => {:in => @@types, :message => "Unknown record type"}
  # RFC 2181, 8
  validates :ttl, :numericality => { :greater_than_or_equal_to => 0, :less_than => 2**31 }, :allow_blank => true
  
  before_validation :prepare_name!
  before_save :update_change_date
  after_save  :update_soa_serial
  
  # By default records don't support priorities.
  # Those who do can overwrite this in their own classes.
  def supports_priority?; false end

  def shortname; name.gsub(/\.?#{self.domain.name}$/, '') end
  def shortname=(value); self.name = value end
  
  protected

  def prepare_name!
    return if domain.nil? or domain.name.blank?
    self.name = domain.name if name.blank? or name == '@'
    self.name << ".#{domain.name}" unless name.index(domain.name)
  end
  
  # Update the change date for automatic serial number generation
  def update_change_date; self.change_date = Time.now.to_i end
  
  def update_soa_serial #:nodoc:
    unless type == 'SOA' || @serial_updated || domain.slave?
      domain.soa_record.update_serial!
      @serial_updated = true
    end
  end
  
end
