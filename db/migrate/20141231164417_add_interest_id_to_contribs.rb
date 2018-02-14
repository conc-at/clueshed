class AddInterestIdToContribs < ActiveRecord::Migration[5.1]
  def change
    add_column :contribs, :interest_id, :integer
  end
end
