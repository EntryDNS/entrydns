require 'spec_helper'

# needs "rake db:test:clone" for the "hosts" part

describe Ability do
  include_context "data"

  context "basic" do
    it "allows me to manage my domains and their records, and my hosts" do
      user.should be_able_to(:manage, domain)
      user.should be_able_to(:manage, a_record)
      user.should be_able_to(:manage, soa_record)
      user.should_not be_able_to(:delete, soa_record) # SOA deleted only via parent
      user.should be_able_to(:manage, host_a_record)
    end
  
    it "denies other user to manage my domains and their records, and my hosts" do
      user2.should_not be_able_to(:manage, domain)
      user2.should_not be_able_to(:manage, a_record)
      user2.should_not be_able_to(:manage, soa_record)
      user2.should_not be_able_to(:manage, host_a_record)
    end
  
    it "allows admin to manage other user's hosts" do
      admin.should be_able_to(:manage, host_a_record)
    end
  end
  
  context "permitted" do
    before do
      permission # ensure permission to domain
    end
    
    it "allows other user to manage user's domains and records, if permitted" do
      user2.should be_able_to(:manage, domain)
      user2.should be_able_to(:manage, a_record)
      user2.should be_able_to(:manage, soa_record)
    end
    
    it "denies third user to manage user's permitted domains and records" do
      user3.should_not be_able_to(:manage, domain)
      user3.should_not be_able_to(:manage, a_record)
      user3.should_not be_able_to(:manage, soa_record)
    end

    it "allows other user to manage user's permitted subdomains" do
      user2.should be_able_to(:manage, subdomain)
      user2.should be_able_to(:manage, subsubdomain)
    end

    it "denies third user to manage other user's permitted subdomains" do
      user3.should_not be_able_to(:manage, subdomain)
      user3.should_not be_able_to(:manage, subsubdomain)
    end
  end
  
  context "permission" do
    it "allows me to manage my domain's permissions" do
      user.should be_able_to(:manage, permission)
    end

    it "denies other user to manage my domain's permissions" do
      user2.should_not be_able_to(:manage, permission)
    end
  end

end
