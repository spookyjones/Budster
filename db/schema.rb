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

ActiveRecord::Schema.define(version: 20150802104034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "price_id"
    t.integer  "strain_id"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["price_id"], name: "index_posts_on_price_id", using: :btree
  add_index "posts", ["region_id"], name: "index_posts_on_region_id", using: :btree
  add_index "posts", ["strain_id"], name: "index_posts_on_strain_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.text     "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "strain_id"
    t.integer  "region_id"
    t.integer  "position"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "post_id"
  end

  add_index "prices", ["post_id"], name: "index_prices_on_post_id", using: :btree
  add_index "prices", ["region_id"], name: "index_prices_on_region_id", using: :btree
  add_index "prices", ["strain_id"], name: "index_prices_on_strain_id", using: :btree
  add_index "prices", ["user_id"], name: "index_prices_on_user_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "strain_id"
    t.integer  "post_id"
  end

  add_index "regions", ["post_id"], name: "index_regions_on_post_id", using: :btree
  add_index "regions", ["strain_id"], name: "index_regions_on_strain_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "name"
    t.string   "review"
    t.integer  "price_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["price_id"], name: "index_reviews_on_price_id", using: :btree

  create_table "strains", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "price_id"
    t.integer  "position"
    t.float    "average_price", default: 0.0, null: false
    t.integer  "post_id"
  end

  add_index "strains", ["average_price"], name: "index_strains_on_average_price", using: :btree
  add_index "strains", ["post_id"], name: "index_strains_on_post_id", using: :btree
  add_index "strains", ["price_id"], name: "index_strains_on_price_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "password"
    t.string   "name"
    t.string   "image"
    t.string   "info"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "posts", "prices"
  add_foreign_key "posts", "regions"
  add_foreign_key "posts", "strains"
  add_foreign_key "posts", "users"
end
