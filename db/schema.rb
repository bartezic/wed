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

ActiveRecord::Schema.define(version: 20131001085051) do

  create_table "admin_user_translations", force: true do |t|
    t.integer  "admin_user_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "admin_user_translations", ["admin_user_id"], name: "index_admin_user_translations_on_admin_user_id", using: :btree
  add_index "admin_user_translations", ["locale"], name: "index_admin_user_translations_on_locale", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "name"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "name_sing"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "categories_partners", id: false, force: true do |t|
    t.integer "partner_id",  null: false
    t.integer "category_id", null: false
  end

  add_index "categories_partners", ["category_id", "partner_id"], name: "index_categories_partners_on_category_id_and_partner_id", using: :btree
  add_index "categories_partners", ["partner_id", "category_id"], name: "index_categories_partners_on_partner_id_and_category_id", using: :btree

  create_table "category_translations", force: true do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "name_sing"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale", using: :btree

  create_table "days", force: true do |t|
    t.date     "day_of_life"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days_partners", id: false, force: true do |t|
    t.integer "partner_id", null: false
    t.integer "day_id",     null: false
  end

  add_index "days_partners", ["partner_id", "day_id"], name: "index_days_partners_on_partner_id_and_day_id", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "rating"
    t.integer  "partner_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["partner_id"], name: "index_galleries_on_partner_id", using: :btree
  add_index "galleries", ["slug"], name: "index_galleries_on_slug", unique: true, using: :btree

  create_table "gallery_translations", force: true do |t|
    t.integer  "gallery_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "gallery_translations", ["gallery_id"], name: "index_gallery_translations_on_gallery_id", using: :btree
  add_index "gallery_translations", ["locale"], name: "index_gallery_translations_on_locale", using: :btree

  create_table "location_translations", force: true do |t|
    t.integer  "location_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "location_translations", ["locale"], name: "index_location_translations_on_locale", using: :btree
  add_index "location_translations", ["location_id"], name: "index_location_translations_on_location_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["slug"], name: "index_locations_on_slug", unique: true, using: :btree

  create_table "locations_partners", id: false, force: true do |t|
    t.integer "partner_id",  null: false
    t.integer "location_id", null: false
  end

  add_index "locations_partners", ["location_id", "partner_id"], name: "index_locations_partners_on_location_id_and_partner_id", using: :btree
  add_index "locations_partners", ["partner_id", "location_id"], name: "index_locations_partners_on_partner_id_and_location_id", using: :btree

  create_table "partner_translations", force: true do |t|
    t.integer  "partner_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.text     "info"
  end

  add_index "partner_translations", ["locale"], name: "index_partner_translations_on_locale", using: :btree
  add_index "partner_translations", ["partner_id"], name: "index_partner_translations_on_partner_id", using: :btree

  create_table "partners", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "info"
    t.integer  "price"
    t.integer  "location_id"
    t.string   "site"
    t.string   "phone"
    t.boolean  "active"
    t.boolean  "premium"
    t.date     "premium_to"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar_remote_url"
    t.integer  "rating"
    t.string   "slug"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["email"], name: "index_partners_on_email", unique: true, using: :btree
  add_index "partners", ["location_id"], name: "index_partners_on_location_id", using: :btree
  add_index "partners", ["reset_password_token"], name: "index_partners_on_reset_password_token", unique: true, using: :btree
  add_index "partners", ["slug"], name: "index_partners_on_slug", unique: true, using: :btree

  create_table "photos", force: true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "asset_remote_url"
    t.integer  "rating"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree

  create_table "video_translations", force: true do |t|
    t.integer  "video_id",    null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "video_translations", ["locale"], name: "index_video_translations_on_locale", using: :btree
  add_index "video_translations", ["video_id"], name: "index_video_translations_on_video_id", using: :btree

  create_table "videos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "asset_remote_url"
    t.integer  "rating",             default: 0
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["partner_id"], name: "index_videos_on_partner_id", using: :btree

end
