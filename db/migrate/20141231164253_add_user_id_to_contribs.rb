class AddUserIdToContribs < ActiveRecord::Migration
  def change
    add_column :contribs, :user_id, :integer
  end
end
