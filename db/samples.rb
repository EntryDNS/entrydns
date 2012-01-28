# more sample users
users = [User.find_by_email('user@entrydns.net')]
for i in 1..5 do
  name = "user#{i}"
  user = User.create!(
    :first_name => name,
    :last_name => name,
    :email => "#{name}@entrydns.net",
    :password => 'useruser',
    :password_confirmation => 'useruser'
  )
  user.confirm!
  users << user unless i > 3
end

entrydns_org = Domain.find_by_name('entrydns.org')
for user in users
  50.times do
    domain = Factory.build(:domain, :user => user)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain.soa_record.update_serial!
  end

  50.times do
    Factory.create(:a, :user => user, :domain => entrydns_org)
  end
end