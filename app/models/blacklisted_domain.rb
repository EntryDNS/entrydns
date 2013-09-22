class BlacklistedDomain < ActiveRecord::Base
  # attr_accessible :name
  
  scope :of, ->(domain_name) {
    where("blacklisted_domains.name = ? OR ? LIKE CONCAT('%.', blacklisted_domains.name)",
      domain_name, domain_name)
  }
  
  def self.include?(domain_name)
    of(domain_name).exists? || Dnsbl.include?(domain_name)
  end
end
