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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140526093613) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                 default: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "blacklisted_domains", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", force: true do |t|
    t.integer  "user_id"
    t.string   "name",                                    null: false
    t.string   "master",          limit: 128
    t.integer  "last_check"
    t.string   "type",            limit: 6,               null: false
    t.integer  "notified_serial"
    t.string   "account",         limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_reversed",                           null: false
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.integer  "parent_id"
    t.integer  "lftp",                        default: 0, null: false
    t.integer  "lftq",                        default: 0, null: false
    t.integer  "rgtp",                        default: 0, null: false
    t.integer  "rgtq",                        default: 0, null: false
    t.float    "lft",             limit: 53,              null: false
    t.float    "rgt",             limit: 53,              null: false
  end

  add_index "domains", ["lft"], name: "index_domains_on_lft", using: :btree
  add_index "domains", ["lftp"], name: "index_domains_on_lftp", using: :btree
  add_index "domains", ["lftq"], name: "index_domains_on_lftq", using: :btree
  add_index "domains", ["name"], name: "name_index", using: :btree
  add_index "domains", ["name_reversed"], name: "index_domains_on_name_reversed", using: :btree
  add_index "domains", ["parent_id"], name: "index_domains_on_parent_id", using: :btree
  add_index "domains", ["rgt"], name: "index_domains_on_rgt", using: :btree
  add_index "domains", ["user_id"], name: "index_domains_on_user_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "domain_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updator_id"
  end

  add_index "permissions", ["domain_id"], name: "index_permissions_on_domain_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "records", force: true do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "type",                 limit: 10
    t.string   "content",              limit: 20000
    t.integer  "ttl"
    t.integer  "prio"
    t.integer  "change_date"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.integer  "updator_id"
  end

  add_index "records", ["authentication_token"], name: "index_records_on_authentication_token", unique: true, using: :btree
  add_index "records", ["domain_id"], name: "domain_id", using: :btree
  add_index "records", ["name", "type"], name: "nametype_index", using: :btree
  add_index "records", ["name"], name: "rec_name_index", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.boolean  "active",                 default: true
    t.string   "full_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "creator_id"
    t.integer  "updator_id"
  end

  add_index "versions", ["creator_id"], name: "index_versions_on_creator_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["updator_id"], name: "index_versions_on_updator_id", using: :btree

end
