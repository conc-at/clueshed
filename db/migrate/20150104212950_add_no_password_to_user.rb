class AddNoPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :no_password, :boolean, default: false
  end
end
