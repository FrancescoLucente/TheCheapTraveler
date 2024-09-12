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

<<<<<<< HEAD
ActiveRecord::Schema[7.1].define(version: 2024_09_08_143220) do
=======
ActiveRecord::Schema[7.1].define(version: 2024_09_09_113618) do
>>>>>>> 136faba2fc52dbecfa9df327f7bf0b6ab2ccf895
  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.float "temperature"
    t.string "weather_description"
    t.datetime "weather_datetime"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "end_date"
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.datetime "event_date"
    t.string "entity_id"
    t.string "link"
    t.index ["city_id"], name: "index_events_on_city_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "image_url"
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_photos_on_city_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "rating"
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["city_id"], name: "index_reviews_on_city_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "trip_type"
    t.string "departure_airport_outbound"
    t.string "arrival_airport_outbound"
    t.datetime "departure_time_outbound"
    t.datetime "arrival_time_outbound"
    t.integer "duration_outbound"
    t.integer "stop_count_outbound"
    t.boolean "is_direct_outbound"
    t.string "departure_airport_inbound"
    t.string "arrival_airport_inbound"
    t.datetime "departure_time_inbound"
    t.datetime "arrival_time_inbound"
    t.integer "duration_inbound"
    t.integer "stop_count_inbound"
    t.boolean "is_direct_inbound"
    t.decimal "total_price"
    t.integer "total_duration"
    t.boolean "is_change_allowed"
    t.boolean "is_cancellation_allowed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.integer "city_id", null: false
    t.float "temperature"
    t.text "description"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_weathers_on_city_id"
  end

  add_foreign_key "events", "cities"
  add_foreign_key "photos", "cities"
  add_foreign_key "reviews", "cities"
  add_foreign_key "reviews", "users"
  add_foreign_key "weathers", "cities"
end
