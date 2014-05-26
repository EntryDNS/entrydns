class AddUserstampsToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :creator_id, :integer
    add_column :versions, :updator_id, :integer
  end
end
