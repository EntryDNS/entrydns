class AddFullNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    execute "UPDATE users SET full_name = CONCAT(first_name, ' ', last_name)"
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
