# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_24_174736) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "permalink"
    t.bigint "company_category_id"
    t.integer "funding_rounds"
    t.string "status"
    t.integer "funded_usd", default: 0
    t.boolean "fully_initialized", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_category_id"], name: "index_companies_on_company_category_id"
  end

  create_table "company_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "funding_rounds", force: :cascade do |t|
    t.bigint "company_id"
    t.string "funding_round_type"
    t.date "funded_date"
    t.integer "funded_usd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_funding_rounds_on_company_id"
  end

  create_table "pending_jobs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pending_jobs_on_name", unique: true
  end

end
