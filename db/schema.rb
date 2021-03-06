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

ActiveRecord::Schema.define(:version => 20120603111003) do

  create_table "locations", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "accuracy"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "material_id"
  end

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.string   "plan_attachment"
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "attachments", ["plan_id"], :name => "index_attachments_on_plan_id"
  add_index "attachments", ["user_id"], :name => "index_attachments_on_user_id"

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "description", :default => ""
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "plan_image"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "plan_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
