# more sample users
users = [User.find_by_email('user@entrydns.net')]
for i in 1..3 do
  name = "user#{i}"
  user = User.new(
    :full_name => name,
    :email => "#{name}@entrydns.net",
    :password => 'useruser',
    :password_confirmation => 'useruser'
  )
  user.confirmed_at = Time.now
  user.save!
  user.confirm!
  users << user unless i > 3
end