admin = Admin.create(
  email: 'admin@entrydns.net',
  password: 'garlik1',
  password_confirmation: 'garlik1'
)
admin.update_attribute(:active, true)
puts 'Admin created'

# an user for administrative purposes
admin = User.new(
  full_name: 'admin admin',
  email: 'admin@entrydns.net',
  password: 'garlik1',
  password_confirmation: 'garlik1'
)
admin.confirmed_at = Time.now
admin.save!
admin.confirm!

Settings.host_domains.each do |name|
  host_domain = admin.domains.build(name: name)
  host_domain.type = 'NATIVE'
  host_domain.setup(admin.email)
  host_domain.save!
end

# sample user
user = User.new(
  full_name: 'user user',
  email: 'user@entrydns.net',
  password: 'useruser',
  password_confirmation: 'useruser'
)
user.confirmed_at = Time.now
user.save!
user.confirm!
