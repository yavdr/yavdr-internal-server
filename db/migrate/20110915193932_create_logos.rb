class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :logo_file_name, :null => false
      t.string :logo_content_type, :null => false
      t.integer :logo_file_size, :null => false
      t.datetime :logo_updated_at, :null => false
      t.timestamps
    end
  end
end
