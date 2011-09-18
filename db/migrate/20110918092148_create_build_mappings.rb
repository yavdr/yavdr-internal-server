class CreateBuildMappings < ActiveRecord::Migration
  def change
    create_table :build_mappings do |t|
      t.string :branch, :null => false, :default => :master
      t.string :stage, :null => false, :default => :unstable
      t.string :dist, :null => false
      t.timestamps
    end
  end
end
