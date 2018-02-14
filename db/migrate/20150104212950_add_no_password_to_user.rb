class AddNoPasswordToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :no_password, :boolean, default: false
  end
end
