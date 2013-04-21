class CreateBlacklistedDomains < ActiveRecord::Migration
  def change
    create_table :blacklisted_domains do |t|
      t.string :name

      t.timestamps
    end
  end
end
