class Dnsbl
  PROVIDER = '.in.dnsbl.org'
  @dns = Resolv::DNS.new
  
  def self.include?(domain_name)
    query(domain_name) != nil
  end
  
  def self.query(domain_name)
    @dns.getresource(domain_name + PROVIDER, Resolv::DNS::Resource::IN::A)
  rescue Resolv::ResolvError
    nil
  end
  
end