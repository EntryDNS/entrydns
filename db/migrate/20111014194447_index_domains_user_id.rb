class IndexDomainsUserId < ActiveRecord::Migration
  def change
    add_index :domains, :user_id
  end
end
