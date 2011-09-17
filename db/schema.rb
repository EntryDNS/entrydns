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

ActiveRecord::Schema.define(:version => 20110917084834) do

  create_table "domains", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "master",          :limit => 128
    t.integer  "last_check",      :limit => 50,  :null => false
    t.string   "type",            :limit => 6,   :null => false
    t.integer  "notified_serial"
    t.string   "account",         :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["name"], :name => "name_index"

  create_table "records", :force => true do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "type",        :limit => 10
    t.string   "content"
    t.integer  "ttl"
    t.integer  "prio"
    t.integer  "change_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["domain_id"], :name => "domain_id"
  add_index "records", ["name", "type"], :name => "nametype_index"
  add_index "records", ["name"], :name => "rec_name_index"

  create_table "supermasters", :force => true do |t|
    t.string   "ip",         :limit => 25, :null => false
    t.string   "nameserver", :limit => 25, :null => false
    t.string   "account"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
