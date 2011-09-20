user = User.create :email => 'user@app.com',
  :password => 'useruser',
  :password_confirmation => 'useruser'
user.confirm!
