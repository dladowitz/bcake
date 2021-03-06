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

ActiveRecord::Schema.define(version: 20150709234132) do

  create_table "customer_signups", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_signups", ["customer_id"], name: "index_customer_signups_on_customer_id"
  add_index "customer_signups", ["location_id"], name: "index_customer_signups_on_location_id"

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.date     "birthday"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "demo_account"
  end

  create_table "deals", force: :cascade do |t|
    t.string   "birthday_deal"
    t.string   "monthly_deal"
    t.integer  "location_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "short_name"
    t.boolean  "active"
  end

  add_index "locations", ["short_name"], name: "index_locations_on_short_name"

  create_table "password_resets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vouchers", force: :cascade do |t|
    t.string   "token"
    t.integer  "customer_id"
    t.integer  "location_id"
    t.datetime "redeemed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "sent"
  end

end
