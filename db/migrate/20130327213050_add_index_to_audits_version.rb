class AddIndexToAuditsVersion < ActiveRecord::Migration
  def change
    add_index(:audits, :version)
  end
end
