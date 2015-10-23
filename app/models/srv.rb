# = Services Record (SRV)
#
# Defines services available in the zone, for example, ldap, http etc..
#
# @see http://www.ietf.org/rfc/rfc2872.txt
# @see http://www.zytrax.com/books/dns/ch8/srv.html
class SRV < Record
  has_paper_trail

  validates :name, :hostname2 => {:allow_wildcard_hostname => true}
  validates :content, :format => /\A\d+ \d+ [A-Za-z0-9\-_.]+\z/
  # RFC 2872
  validates :prio, :presence => true, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 65535,
    :only_integer => true
  }
  validates :weight, :presence => true, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 65535,
    :only_integer => true
  }
  validates :port, :presence => true, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 65535,
    :only_integer => true
  }
  validates :host, :presence => true, :hostname2 => {:allow_wildcard_hostname => true}

  attr_accessor :weight, :port, :host

  before_validation :assemble_content
  after_initialize :disassemble_content

  def supports_priority?; true end

  protected

  def assemble_content
    self.content = "#{@weight} #{@port} #{@host}".strip
  end

  # Update our convenience accessors when the object has changed
  def disassemble_content
    @weight, @port, @host = content.split(/\s+/) unless content.blank?
  end

end

Srv = SRV
