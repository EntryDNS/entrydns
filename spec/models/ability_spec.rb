require 'spec_helper'

# needs "rake db:test:clone" for the "hosts" part

describe Ability do
  include_context "data"

  it "allows me to manage my domains and their records, and my hosts" do
    ability.should be_able_to(:manage, domain)
    ability.should be_able_to(:manage, a_record)
    ability.should be_able_to(:manage, soa_record)
    ability.should_not be_able_to(:delete, soa_record) # SOA deleted only via parent
    ability.should be_able_to(:manage, host_a_record)
  end
  
  it "denies other user to manage my domains and their records" do
    other_user_ability.should_not be_able_to(:manage, domain)
    other_user_ability.should_not be_able_to(:manage, a_record)
    other_user_ability.should_not be_able_to(:manage, soa_record)
    other_user_ability.should_not be_able_to(:manage, host_a_record)
  end
  
  it "allows admin to manage other user's hosts" do
    admin_ability.should be_able_to(:manage, host_a_record)
  end

end
