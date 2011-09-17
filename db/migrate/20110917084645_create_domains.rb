class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name, :limit => 255, :null => false
      t.string :master, :limit => 128
      t.integer :last_check, :limit => 50, :null => false
      t.string :type, :limit => 6, :null => false
      t.integer :notified_serial
      t.string :account, :limit => 40

      t.timestamps
    end
    
    add_index :domains, :name, :name => 'name_index'
  end
end
