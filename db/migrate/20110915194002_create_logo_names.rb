class CreateLogoNames < ActiveRecord::Migration
  def change
    create_table :logo_names do |t|
      t.integer :logo_id, :null => false
      t.string :name, :null => false
    end
  end
end
