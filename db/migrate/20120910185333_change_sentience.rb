class ChangeSentience < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :created_by_id, :creator_id
      t.rename :updated_by_id, :updator_id
    end
    change_table :domains do |t|
      t.rename :created_by_id, :creator_id
      t.rename :updated_by_id, :updator_id
    end
    change_table :records do |t|
      t.rename :created_by_id, :creator_id
      t.rename :updated_by_id, :updator_id
    end
    change_table :permissions do |t|
      t.rename :created_by_id, :creator_id
      t.rename :updated_by_id, :updator_id
    end
    User.reset_column_information
    Domain.reset_column_information
    Domain.inheritance_column = :sti_disabled
    Record.reset_column_information
    Permission.reset_column_information
  end
end
