class AddCommitMailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commit_mail, :boolean, :default => false, :null => false
  end
end
