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

ActiveRecord::Schema.define(version: 2021_08_26_214011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_admin_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "buyers", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_buyers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_buyers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "rfp_id", null: false
    t.bigint "location_id", null: false
    t.integer "delivery_days", default: [], array: true
    t.integer "deliveries_per_week"
    t.integer "delivery_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_deliveries_on_location_id"
    t.index ["rfp_id"], name: "index_deliveries_on_rfp_id"
  end

  create_table "district_profiles", force: :cascade do |t|
    t.string "district_name", null: false
    t.string "city"
    t.string "county"
    t.integer "enrolled_students_number"
    t.integer "daily_meals_number"
    t.integer "schools_number"
    t.integer "production_sites_number"
    t.bigint "buyer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contact_full_name"
    t.string "contact_department_name"
    t.string "contact_title"
    t.string "contact_phone_number"
    t.string "contact_mailing_address_street"
    t.string "contact_mailing_address_city"
    t.string "contact_mailing_address_state"
    t.string "contact_mailing_address_zip"
    t.integer "local_percentage"
    t.boolean "price_verified"
    t.boolean "allow_piggyback"
    t.integer "required_insurance_per_incident"
    t.integer "required_insurance_aggregate"
    t.integer "required_insurance_automobile"
    t.index ["buyer_id"], name: "index_district_profiles_on_buyer_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.string "name", null: false
    t.string "street_address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_locations_on_buyer_id"
  end

  create_table "rfps", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.integer "start_year", null: false
    t.integer "bid_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_rfps_on_buyer_id"
  end

  create_table "score_categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "position", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_score_categories_on_deleted_at"
    t.index ["position"], name: "index_score_categories_on_position"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "rfp_id", null: false
    t.bigint "score_category_id", null: false
    t.integer "value", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rfp_id"], name: "index_scores_on_rfp_id"
    t.index ["score_category_id"], name: "index_scores_on_score_category_id"
  end

  add_foreign_key "deliveries", "locations"
  add_foreign_key "deliveries", "rfps"
  add_foreign_key "district_profiles", "buyers"
  add_foreign_key "locations", "buyers"
  add_foreign_key "rfps", "buyers"
  add_foreign_key "scores", "rfps"
  add_foreign_key "scores", "score_categories"
end
