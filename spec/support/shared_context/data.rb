shared_context "data" do
  let(:admin){create(:user)} # admin is a user that owns host domains
  let(:user){create(:user)} # a regular user
  let(:user2){create(:user)}
  let(:user3){create(:user)}

  def make_domain(options)
    domain = build(:domain, options)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain.soa_record.update_serial!
    domain
  end

  # user's domains
  let(:domain){make_domain(:user => user)}
  let(:subdomain){make_domain(:name => "sub.#{domain.name}", :user => user)}
  let(:subsubdomain){make_domain(:name => "sub.#{subdomain.name}", :user => user)}

  # third user's domains
  let(:domain3){make_domain(:user => user3)}
  let(:subdomain3){make_domain(:name => "sub.#{domain.name}", :user => user3)}
  let(:subsubdomain3){make_domain(:name => "sub.#{subdomain.name}", :user => user3)}

  # admin's host domain (like entrydns.org)
  let(:host_domain){make_domain(:user => admin, :name => Settings.host_domains.first)}

  let(:a_record){create(:a, :content => '127.0.0.1', :domain => domain)}
  let(:soa_record){domain.soa_record}
  let(:host_a_record){create(:a, :content => '127.0.0.1', :domain => host_domain, :user => user)}

  let(:permission){create(:permission, :domain => domain, :user => user2)}
  let(:permission3){create(:permission, :domain => domain3, :user => user)}

  let(:blacklisted_domain){create(:blacklisted_domain)}

  # admin model
  let(:admin_admin){create(:admin)}

end
