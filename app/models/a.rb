# See #A

# = IPv4 Address Record (A)
#
# Defined in RFC 1035. Forward maps a host name to IPv4 address. The only
# parameter is an IP address in dotted decimal format. The IP address in not
# terminated with a '.' (dot). Valid host name format (a.k.a 'label' in DNS
# jargon). If host name is BLANK (or space) then the last valid name (or label)
# is substituted.
#
# Obtained from http://www.zytrax.com/books/dns/ch8/a.html
#
class A < Record
  has_paper_trail

  validates :name, :hostname2 => {:allow_wildcard_hostname => true}
  validates :content, :presence => true, :ip => {:ip_type => :v4} # Only accept valid IPv4 addresses

  attr_accessor :host_domain
  validates :host_domain, :inclusion => {:in => Settings.host_domains}, :allow_blank => true

  validates :name,
    :length => {:minimum => 4},
    :uniqueness => {:scope => [:domain_id, :type]},
    :if => :host?

  validate do
    if host? && Settings.protected_hostnames.any? {|hn| name =~ /^#{hn}/i}
      errors[:name] << "cannot be used, please try another"
    end
  end

  before_validation do
    if host_domain.present? && Settings.host_domains.include?(host_domain)
      self.domain_id = Domain.find_by_name(host_domain).try(:id)
    end
  end

  def host?; domain.present? && Settings.host_domains.include?(domain.name) end
end
