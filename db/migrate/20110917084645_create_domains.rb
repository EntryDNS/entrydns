class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.references :user
      t.string :name, :limit => 255, :null => false
      t.string :master, :limit => 128, :default => nil
      t.integer :last_check, :default => nil
      t.string :type, :limit => 6, :null => false
      t.integer :notified_serial, :default => nil
      t.string :account, :limit => 40, :default => nil

      t.timestamps
    end
    
    add_index :domains, :name, :name => 'name_index'
  end
end
