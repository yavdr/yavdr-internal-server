class AddBuildTypeToGithubRepository < ActiveRecord::Migration
  def change
    add_column :github_repositories, :build_type, :string
  end
end
