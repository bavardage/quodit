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

ActiveRecord::Schema.define(:version => 20110822000846) do

  create_table "memberships", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "wall_id",    :null => false
    t.string   "role",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.integer  "author_id",  :null => false
    t.string   "text",       :null => false
    t.integer  "wall_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes_users", :id => false, :force => true do |t|
    t.integer "quote_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "role",       :default => "basic", :null => false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
  end

  create_table "users_walls", :id => false, :force => true do |t|
    t.integer "wall_id"
    t.integer "user_id"
  end

  create_table "walls", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
