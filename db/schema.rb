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

ActiveRecord::Schema.define(version: 20150619082445) do

  create_table "prices", force: :cascade do |t|
    t.string   "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "strain_id"
    t.integer  "region_id"
    t.integer  "position"
  end

  add_index "prices", ["region_id"], name: "index_prices_on_region_id"
  add_index "prices", ["strain_id"], name: "index_prices_on_strain_id"

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "price_id"
  end

  add_index "regions", ["price_id"], name: "index_regions_on_price_id"

  create_table "strains", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "region_id"
    t.integer  "price_id"
    t.integer  "position"
  end

  add_index "strains", ["price_id"], name: "index_strains_on_price_id"
  add_index "strains", ["region_id"], name: "index_strains_on_region_id"

end
