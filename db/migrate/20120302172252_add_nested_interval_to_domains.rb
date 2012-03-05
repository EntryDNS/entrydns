class AddNestedIntervalToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :parent_id, :integer
    add_column :domains, :lftp, :integer, null: false, default: 0
    add_column :domains, :lftq, :integer, null: false, default: 0
    add_column :domains, :rgtp, :integer, null: false
    add_column :domains, :rgtq, :integer, null: false
    add_column :domains, :lft, :float, null: false, limit: 53
    add_column :domains, :rgt, :float, null: false, limit: 53

    add_index :domains, :parent_id
    add_index :domains, :lftp
    add_index :domains, :lftq
    add_index :domains, :lft
    add_index :domains, :rgt
    
    Domain.class_exec do
      reset_column_information
      self.inheritance_column = "sti_disabled"
      acts_as_nested_interval virtual_root: true
      skip_callback :update, :before, :update_nested_interval
      skip_callback :update, :before, :sync_children
    end
    Domain.scoped.each do |d|
      d.create_nested_interval
      d.save!
    end
   
  end
end
