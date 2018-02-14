class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :uid
      t.integer :user_id
      t.integer :contrib_id
      t.integer :interest_id

      t.timestamps
    end
    add_index :votes, :uid, unique: true
  end
end
