class AddUserIdToContribs < ActiveRecord::Migration[5.1]
  def change
    add_column :contribs, :user_id, :integer
  end
end
