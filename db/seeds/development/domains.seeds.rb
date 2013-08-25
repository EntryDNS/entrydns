after 'development:users' do
  
  entrydns_org = Domain.find_by_name(Settings.host_domains.first)
  User.all.each do |user|
    Audit.as_user(user) do
      20.times do
        domain = Factory.build(:domain, :user => user)
        domain.setup(FactoryGirl.generate(:email))
        domain.save!
        domain.soa_record.update_serial!
      end

      20.times do
        Factory.create(:a, :user => user, :domain => entrydns_org)
      end
    end
  end
  
end
