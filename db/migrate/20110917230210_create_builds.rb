class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.references :github_repository
      t.string :branch, :null => false, :default => :master
      t.string :dist, :null => false
      t.string :stage, :null => false, :default => :unstable
      t.string :status, :null => false, :default => :waiting
      t.text :log
      t.timestamps
    end
  end
end
