class CreateGithubRepositories < ActiveRecord::Migration
  def change
    create_table :github_repositories do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.boolean :active, :null => false, :default => false
      t.timestamps
    end
  end
end
