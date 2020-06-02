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

ActiveRecord::Schema.define(version: 2020_06_02_022217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "stock_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_code"], name: "index_portfolios_on_stock_code"
    t.index ["user_id", "stock_code"], name: "index_portfolios_on_user_id_and_stock_code", unique: true
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "stock_indexes", force: :cascade do |t|
    t.string "name", null: false
    t.float "today_price", default: 1.0, null: false
    t.float "yesterday_price", default: 1.0, null: false
    t.float "dod_change", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stocks", id: false, force: :cascade do |t|
    t.integer "code", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "today_price"
    t.float "yesterday_price"
    t.float "dod_change", default: 0.0, null: false
    t.index ["code"], name: "index_stocks_on_code", unique: true
    t.index ["dod_change"], name: "index_stocks_on_dod_change"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "portfolio_average", default: 0.0
    t.index ["portfolio_average"], name: "index_users_on_portfolio_average"
  end

end
