# = IPv6 Address Record (AAAA)
#
# IPv6 Address record. An IPv6 address for a host. Current IETF recommendation for IPv6
# forward-mapped zones.
#
# @see http://www.ietf.org/rfc/rfc3596.txt
# @see http://www.zytrax.com/books/dns/ch8/aaaa.html
class AAAA < Record
  validates :name, :hostname => {:allow_underscore => true, :allow_wildcard_hostname => true}
  validates :content, :presence => true, :ip => {:ip_type => :v6}
  
end

Aaaa = AAAA
