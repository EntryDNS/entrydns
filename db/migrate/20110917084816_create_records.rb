class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :domain
      t.string :name, :limit => 255
      t.string :type, :limit => 10
      t.string :content, :limit => 255
      t.integer :ttl
      t.integer :prio
      t.integer :change_date
      t.string :authentication_token

      t.timestamps
    end
    
    add_index :records, :name, :name => 'rec_name_index'
    add_index :records, [:name, :type], :name => 'nametype_index'
    add_index :records, :domain_id, :name => 'domain_id'
    add_index :records, :authentication_token, :unique => true
  end
end
