# an user for administrative purposes
admin = User.new(
  :first_name => 'admin',
  :last_name => 'admin',
  :email => 'admin@entrydns.net',
  :password => 'garlik1',
  :password_confirmation => 'garlik1'
)
admin.confirmed_at = Time.now
admin.save!
admin.confirm!

Settings.host_domains.each do |name|
  entrydns_org = Domain.new(:name => name, :type => 'NATIVE', :user_id => admin.id)
  entrydns_org.setup(admin.email)
  entrydns_org.save!
end

# sample user
user = User.new(
  :first_name => 'user',
  :last_name => 'user',
  :email => 'user@entrydns.net',
  :password => 'useruser',
  :password_confirmation => 'useruser'
)
user.confirmed_at = Time.now
user.save!
user.confirm!
