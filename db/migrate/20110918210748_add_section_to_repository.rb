class AddSectionToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :section, :string, :default => :yavdr, :null => false
  end
end
