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

ActiveRecord::Schema.define(version: 20150129215201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "name_sing"
    t.string   "slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "logo_remote_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_description"
    t.string   "meta_keywords"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "cooperations", force: true do |t|
    t.integer  "partner_id"
    t.integer  "co_id"
    t.boolean  "confirmed"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cooperations", ["partner_id"], name: "index_cooperations_on_partner_id", using: :btree

  create_table "days", force: true do |t|
    t.date     "day_of_life"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days_partners", id: false, force: true do |t|
    t.integer "partner_id", null: false
    t.integer "day_id",     null: false
  end

  add_index "days_partners", ["day_id", "partner_id"], name: "index_days_partners_on_day_id_and_partner_id", using: :btree
  add_index "days_partners", ["partner_id", "day_id"], name: "index_days_partners_on_partner_id_and_day_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.integer  "partner_id"
    t.string   "subject"
    t.string   "name"
    t.string   "email"
    t.text     "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["partner_id"], name: "index_feedbacks_on_partner_id", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "rating",      default: 0
    t.integer  "partner_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "galleries", ["partner_id"], name: "index_galleries_on_partner_id", using: :btree
  add_index "galleries", ["slug"], name: "index_galleries_on_slug", unique: true, using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "involvings", force: true do |t|
    t.integer "price"
    t.integer "partner_id"
    t.integer "category_id"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_m"
  end

  add_index "locations", ["slug"], name: "index_locations_on_slug", unique: true, using: :btree

  create_table "locations_partners", id: false, force: true do |t|
    t.integer "partner_id",  null: false
    t.integer "location_id", null: false
  end

  add_index "locations_partners", ["location_id", "partner_id"], name: "index_locations_partners_on_location_id_and_partner_id", using: :btree
  add_index "locations_partners", ["partner_id", "location_id"], name: "index_locations_partners_on_partner_id_and_location_id", using: :btree

  create_table "managers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "info"
    t.integer  "price"
    t.integer  "location_id"
    t.string   "site"
    t.string   "phone"
    t.hstore   "socials"
    t.boolean  "callendar",   default: true
    t.boolean  "active",      default: false
    t.boolean  "premium",     default: false
    t.date     "premium_to"
    t.integer  "rating",      default: 0
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["location_id"], name: "index_partners_on_location_id", using: :btree
  add_index "partners", ["slug"], name: "index_partners_on_slug", unique: true, using: :btree

  create_table "photos", force: true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "asset_remote_url"
    t.integer  "rating",             default: 0
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "photos", ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree

  create_table "slider_ads", force: true do |t|
    t.integer  "partner_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "asset_remote_url"
    t.hstore   "text"
    t.boolean  "active"
    t.date     "active_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slider_ads", ["partner_id"], name: "index_slider_ads_on_partner_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar_remote_url"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "temp_password"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "link"
    t.integer  "rating",     default: 0
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "videos", ["partner_id"], name: "index_videos_on_partner_id", using: :btree

end
