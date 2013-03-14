class AddActiveToAdminsAndUsers < ActiveRecord::Migration
  def change
    add_column :admins, :active, :boolean, default: false
    admin = Admin.where(email: 'admin@entrydns.net').first
    admin.update_attribute(:active, true) if admin
    
    add_column :users, :active, :boolean, default: true
  end
end
