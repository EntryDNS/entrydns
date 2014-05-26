after 'development:users' do
  
  entrydns_org = Domain.find_by_name(Settings.host_domains.first)
  User.all.each do |user|
    User.do_as(user) do
      20.times do
        domain = FactoryGirl.build(:domain, :user => user)
        domain.setup(FactoryGirl.generate(:email))
        domain.save!
        domain.soa_record.update_serial!
      end

      20.times do
        FactoryGirl.create(:a, :user => user, :domain => entrydns_org)
      end
    end
  end
  
end
