class ChangePartipsDescriptionType < ActiveRecord::Migration
  def up
    change_column :contribs, :description, :text
    change_column :interests, :description, :text
  end
  def down
    change_column :contribs, :description, :string
    change_column :interests, :description, :string
  end
end
