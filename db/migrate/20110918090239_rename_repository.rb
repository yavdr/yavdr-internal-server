class RenameRepository < ActiveRecord::Migration
  def up
    rename_table :github_repositories, :repositories
    rename_column :builds, :github_repository_id, :repository_id
  end

  def down
    rename_table :repositories, :github_repositories
    rename_column :builds, :repository_id, :github_repository_id
  end
end
