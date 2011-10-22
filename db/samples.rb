
user = User.find_by_email('user@entrydns.net')
entrydns_org = Domain.find_by_name('entrydns.org')

100.times do
  domain = Factory.build(:domain, :user => user)
  domain.setup(FactoryGirl.generate(:email))
  domain.save!
  domain.soa_record.update_serial!
end

100.times do
  Factory.create(:a, :user => user, :domain => entrydns_org)
end
