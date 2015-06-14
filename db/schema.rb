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

ActiveRecord::Schema.define(version: 20150614022025) do

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.date     "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers_locations", id: false, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "location_id"
  end

  add_index "customers_locations", ["customer_id"], name: "index_customers_locations_on_customer_id"
  add_index "customers_locations", ["location_id"], name: "index_customers_locations_on_location_id"

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
  end

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
  end

end
