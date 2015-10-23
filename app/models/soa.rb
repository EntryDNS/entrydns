# See #SOA

# = Start of Authority Record
# Defined in RFC 1035. The SOA defines global parameters for the zone (domain).
# There is only one SOA record allowed in a zone file.
#
# Obtained from http://www.zytrax.com/books/dns/ch8/soa.html
#
class SOA < Record
  has_paper_trail

  validates :domain, :presence => true
  validates :domain_id, :uniqueness => true # one SOA per domain
  validates :name, :presence => true, :hostname2 => true
  validate  :name_equals_domain_name
  validates :content, :presence => true
  validates :primary_ns, :presence => true
  validates :contact, :email => true
  validates :serial, :presence => true, :numericality => {:allow_blank => true, :greater_than_or_equal_to => 0}

  before_validation :assemble_content
  before_update :update_serial
  after_initialize :disassemble_content

  before_validation do
    self.primary_ns ||= domain.ns_records.first.try(:content)
  end

  # This allows us to have these convenience attributes act like any other
  # column in terms of validations
  attr_accessor :primary_ns, :contact, :serial

  # Treat contact specially
  # replacing the first period with an @ if no @'s are present
  def contact=(email)
    email.sub!('.', '@') if email.present? && email.index('@').nil?
    @contact = email
  end

  # Hook into #reload
  def reload_with_content
    reload_without_content
    disassemble_content
  end
  alias_method_chain :reload, :content

  # Updates the serial number to the next logical one. Format of the generated
  # serial is YYYYMMDDNN, where NN is the number of the change for the day.
  # 01 for the first change, 02 the seconds, etc...
  #
  # If the serial number is 0, we opt for PowerDNS's automatic serial number
  # generation, that gets triggered by updating the change_date
  def update_serial
    return if content_changed?
    compute_serial
  end

  def reset_serial
    @serial = nil
    compute_serial
  end

  # Same as #update_serial and saves the record
  def update_serial!
    update_serial
    save!
  end

  # if SOA record's primary NS is among it's domain's NS records
  def ns?
    domain.has_ns?(primary_ns)
  end

  def to_label; "#{primary_ns} #{contact}" end

  private

  def assemble_content
    self.content = "#{@primary_ns} #{@contact} #{@serial}".strip
  end

  # Update our convenience accessors when the object has changed
  def disassemble_content
    @primary_ns, @contact, @serial = content.split(/\s+/) unless content.blank?
    @serial = @serial.to_i unless @serial.nil?
    update_serial if @serial.nil? || @serial.zero?
  end

  def compute_serial
    date_serial = Time.now.strftime( "%Y%m%d00" ).to_i
    @serial = (@serial.nil? || date_serial > @serial) ? date_serial : @serial + 1
  end

end

Soa = SOA
