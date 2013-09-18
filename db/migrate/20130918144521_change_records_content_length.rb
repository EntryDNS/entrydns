class ChangeRecordsContentLength < ActiveRecord::Migration
  def change
    change_column :records, :content, :string, limit: 20000
  end
end
