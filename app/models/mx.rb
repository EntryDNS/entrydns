# See #MX

# = Mail Exchange Record (MX)
# Defined in RFC 1035. Specifies the name and relative preference of mail
# servers (mail exchangers in the DNS jargon) for the zone.
#
# Obtained from http://www.zytrax.com/books/dns/ch8/mx.html
#
class MX < Record
  has_paper_trail

  validates :name, :hostname2 => {:allow_wildcard_hostname => true}
  validates :content, :presence => true, :hostname2 => {:allow_wildcard_hostname => true}
  validates :prio, :presence => true, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 65535,
    :only_integer => true
  }

  def supports_priority?; true end
end

Mx = MX
