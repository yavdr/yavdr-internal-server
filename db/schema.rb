# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110915194002) do

  create_table "logo_names", :force => true do |t|
    t.integer "logo_id", :null => false
    t.string  "name",    :null => false
  end

  create_table "logos", :force => true do |t|
    t.string   "logo_file_name",    :null => false
    t.string   "logo_content_type", :null => false
    t.integer  "logo_file_size",    :null => false
    t.datetime "logo_updated_at",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
