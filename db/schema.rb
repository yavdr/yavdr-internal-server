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

ActiveRecord::Schema.define(:version => 20110918224109) do

  create_table "build_mappings", :force => true do |t|
    t.string   "branch",     :default => "master",   :null => false
    t.string   "stage",      :default => "unstable", :null => false
    t.string   "dist",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "builds", :force => true do |t|
    t.integer  "repository_id"
    t.string   "branch",        :default => "master",   :null => false
    t.string   "dist",                                  :null => false
    t.string   "stage",         :default => "unstable", :null => false
    t.string   "status",        :default => "waiting",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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

  create_table "repositories", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "url",                             :null => false
    t.boolean  "active",     :default => false,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "build_type"
    t.string   "section",    :default => "yavdr", :null => false
  end

  create_table "users", :force => true do |t|
    t.boolean  "yavdr",                                 :default => false, :null => false
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.boolean  "commit_mail",                           :default => false, :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
