class BlacklistedDomain < ActiveRecord::Base
  # attr_accessible :name
  
  def self.include?(name)
    where("blacklisted_domains.name = ? OR ? LIKE CONCAT('%.', blacklisted_domains.name)",
      name, name).exists?
  end
end
