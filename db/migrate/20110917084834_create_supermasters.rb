class CreateSupermasters < ActiveRecord::Migration
  def change
    create_table :supermasters do |t|
      t.string :ip, :limit => 25, :null => false
      t.string :nameserver, :limit => 25, :null => false
      t.string :account, :limit => 255

      t.timestamps
    end
  end
end
