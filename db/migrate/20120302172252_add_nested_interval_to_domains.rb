Domain.class_exec do
  def ancestor_of?(node); false end
  def descendants; subdomains end
end

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
        
    Domain.reset_column_information
    Domain.inheritance_column = "sti_disabled"
    Domain.scoped.each &:save
  end
end
