class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    remove_column :users, :yavdr, :boolean, :default => false, :null => false
  end
end
