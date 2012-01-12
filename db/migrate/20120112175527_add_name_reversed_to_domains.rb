class AddNameReversedToDomains < ActiveRecord::Migration
  def up
    # used for "%" search indexing in an ancestry fashion (materialized path pattern)
    # http://dev.mysql.com/doc/refman/5.0/en/mysql-indexes.html
    add_column :domains, :name_reversed, :string, :limit => 255
    execute "UPDATE domains SET name_reversed = REVERSE(name)"
    change_column :domains, :name_reversed, :string, :limit => 255, :null => false
    add_index :domains, :name_reversed
  end
  
  def down
    remove_index :domains, :column => :name_reversed
    remove_column :domains, :name_reversed
  end
end
