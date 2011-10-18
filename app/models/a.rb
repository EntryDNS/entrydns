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
  validates :name, :hostname => {:allow_underscore => true, :allow_wildcard_hostname => true}
  validates :content, :presence => true, :ip => {:ip_type => :v4} # Only accept valid IPv4 addresses

  attr_accessor :host_domain
  validates :host_domain, :inclusion => {:in => Settings.host_domains}, :allow_blank => true

  validate do
    if Settings.host_domains.include?(domain.name)
      for hostname in Settings.protected_hostnames
        if name =~ /^#{hostname}/i
          errors[:name] << "cannot be used, please try another"
          break
        end
      end
    end
  end
  
  before_validation do
    if host_domain.present? && Settings.host_domains.include?(host_domain)
      self.domain_id = Domain.find_by_name(host_domain).try(:id)
    end
  end
  
end
