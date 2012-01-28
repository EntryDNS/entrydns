# an user for administrative purposes
admin = User.create!(
  :first_name => 'admin',
  :last_name => 'admin',
  :email => 'admin@entrydns.net',
  :password => 'garlik1',
  :password_confirmation => 'garlik1'
)
admin.confirm!

for name in Settings.host_domains
  entrydns_org = Domain.new(:name => name, :type => 'NATIVE', :user_id => admin.id)
  entrydns_org.setup(admin.email)
  entrydns_org.save!
end

# sample user
user = User.create!(
  :first_name => 'user',
  :last_name => 'user',
  :email => 'user@entrydns.net',
  :password => 'useruser',
  :password_confirmation => 'useruser'
)
user.confirm!
