class BlacklistedDomain < ActiveRecord::Base
  # attr_accessible :name

  scope :of, ->(domain_name) {
    domain_name_quoted = connection.quote(domain_name)
    where{
      (name == domain_name) |
      (`#{domain_name_quoted}` =~ CONCAT('%.', name))
    }
  }

  def self.include?(domain_name)
    of(domain_name).exists? # || Dnsbl.include?(domain_name)
  end
end
