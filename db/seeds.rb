
# an user for administrative purposes
admin = User.create(
  :first_name => 'admin',
  :last_name => 'admin',
  :email => 'admin@entrydns.com',
  :password => 'garlik1',
  :password_confirmation => 'garlik1'
)
admin.confirm!

for name in Settings.host_domains
  entrudns_org = Domain.new(:name => name, :type => 'NATIVE', :user_id => admin.id)
  entrudns_org.setup(admin.email)
  entrudns_org.save!
end

# sample user
user = User.create!(
  :first_name => 'user',
  :last_name => 'user',
  :email => 'user@app.com',
  :password => 'useruser',
  :password_confirmation => 'useruser'
)
user.confirm!
