class AddUserIdToInterests < ActiveRecord::Migration[5.1]
  def change
    add_column :interests, :user_id, :integer
  end
end
