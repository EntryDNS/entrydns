shared_context "data" do
  
  let(:user){create(:user)}
  let(:ability){Ability.new(:user => user)}

  let(:other_user){create(:user)}
  let(:other_user_ability){Ability.new(:user => other_user)}
  
  let(:domain){
    domain = build(:domain, :user => user)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain.soa_record.update_serial!
    domain
  }
  let(:a_record){create(:a, :content => '127.0.0.1', :domain => domain)}
  let(:soa_record){domain.soa_record}
  
  # admin is a user that owns host domains
  let(:admin){
    admin_user = create(:user,
      :first_name => 'admin',
      :last_name => 'admin',
      :email => 'admin@entrydns.net',
      :confirmed_at => Time.now
    )
    admin_user.confirm!
    admin_user
  }
  let(:admin_ability){Ability.new(:user => admin)}
  
  let(:host_domain){
    domain = build(:domain, :user => admin, :name => Settings.host_domains.first)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain.soa_record.update_serial!
    domain
  }
  let(:host_a_record){create(:a, :content => '127.0.0.1', :domain => host_domain, :user => user)}

  let(:permission){create(:permission, :domain => domain, :user => other_user)}
    
end
