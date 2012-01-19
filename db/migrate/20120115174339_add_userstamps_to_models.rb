class AddUserstampsToModels < ActiveRecord::Migration
  def change
    add_column :users, :created_by_id, :integer
    add_column :users, :updated_by_id, :integer
    execute "UPDATE users SET created_by_id = id, updated_by_id = id"
    
    add_column :domains, :created_by_id, :integer
    add_column :domains, :updated_by_id, :integer
    execute "UPDATE domains SET created_by_id = user_id, updated_by_id = user_id"
    
    add_column :records, :created_by_id, :integer
    add_column :records, :updated_by_id, :integer
    execute <<-SQL
      UPDATE records
      LEFT JOIN domains ON records.domain_id = domains.id
      SET 
        records.created_by_id = IFNULL(records.user_id, domains.user_id),
        records.updated_by_id = IFNULL(records.user_id, domains.user_id)
    SQL
    
    add_column :permissions, :created_by_id, :integer
    add_column :permissions, :updated_by_id, :integer
    execute <<-SQL
      UPDATE permissions
      LEFT JOIN domains ON permissions.domain_id = domains.id
      SET
        permissions.created_by_id = domains.user_id,
        permissions.updated_by_id = domains.user_id
    SQL
  end
end
