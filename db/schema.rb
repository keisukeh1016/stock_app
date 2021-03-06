# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_07_112947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "stock_code", null: false
    t.string "comparison", null: false
    t.float "price", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_alerts_on_user_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "stock_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "holding", null: false
    t.index ["stock_code"], name: "index_portfolios_on_stock_code"
    t.index ["user_id", "stock_code"], name: "index_portfolios_on_user_id_and_stock_code", unique: true
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "stocks", id: false, force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", default: "unknown", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "today_price", default: 1.0, null: false
    t.float "yesterday_price", default: 1.0, null: false
    t.index ["code"], name: "index_stocks_on_code", unique: true
    t.index ["today_price", "yesterday_price"], name: "index_stocks_on_today_price_and_yesterday_price"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "cash", default: 100000.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wallets_on_user_id", unique: true
  end

end
