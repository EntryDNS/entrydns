require 'spec_helper'

# needs "rake db:test:clone" for the "hosts" part

describe UserAbility do
  include_context "data"
  let(:crud){UserAbility::CRUD}

  context "basic" do
    it "allows me to manage my domains and their records, and my hosts" do
      user.should be_able_to(crud, domain)
      user.should be_able_to(crud, a_record)
      user.should be_able_to(crud, soa_record)
      user.should_not be_able_to(:delete, soa_record) # SOA deleted only via parent
      user.should be_able_to(crud, host_a_record)
    end

    it "denies other user to manage my domains and their records, and my hosts" do
      user2.should_not be_able_to(crud, domain)
      user2.should_not be_able_to(crud, a_record)
      user2.should_not be_able_to(crud, soa_record)
      user2.should_not be_able_to(crud, host_a_record)
    end

    it "allows admin to manage other user's hosts" do
      admin.should be_able_to(crud, host_a_record)
    end
  end

  context "permitted" do
    before do
      User.do_as(user) do
        domain
        subdomain
        subsubdomain
        permission # ensure permission to domain
      end
    end

    it "allows other user to manage user's domains and records, if permitted" do
      User.do_as(user2) do
        user2.should be_able_to(crud, domain)
        user2.should be_able_to(crud, a_record)
        user2.should be_able_to(crud, soa_record)
      end
    end

    it "denies third user to manage user's permitted domains and records" do
      User.do_as(user3) do
        user3.should_not be_able_to(crud, domain)
        user3.should_not be_able_to(crud, a_record)
        user3.should_not be_able_to(crud, soa_record)
      end
    end

    it "allows other user to manage user's permitted subdomains" do
      User.do_as(user2) do
        user2.should be_able_to(crud, subdomain)
        user2.should be_able_to(crud, subsubdomain)
      end
    end

    it "denies third user to manage other user's permitted subdomains" do
      User.do_as(user3) do
        user3.should_not be_able_to(crud, subdomain)
        user3.should_not be_able_to(crud, subsubdomain)
      end
    end
  end

  context "permission" do
    it "allows me to manage my domain's permissions" do
      user.should be_able_to(crud, permission)
    end

    it "denies other user to manage my domain's permissions" do
      user2.should_not be_able_to(crud, permission)
    end
  end

end
