class AddUserstampsToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :creator_id, :integer
    add_column :versions, :updator_id, :integer
    add_index :versions, :creator_id
    add_index :versions, :updator_id
  end
end
