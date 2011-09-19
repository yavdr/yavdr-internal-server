class RemoveLogFromBuild < ActiveRecord::Migration
  def change
    remove_column :builds, :log
  end
end
