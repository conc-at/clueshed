class AddInterestIdToContribs < ActiveRecord::Migration
  def change
    add_column :contribs, :interest_id, :integer
  end
end
