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

ActiveRecord::Schema[7.0].define(version: 2022_11_12_154250) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "age_groups", force: :cascade do |t|
    t.integer "min_age"
    t.integer "max_age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "area_assignments", force: :cascade do |t|
    t.bigint "counting_area_id", null: false
    t.bigint "counting_signup_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["counting_area_id"], name: "index_area_assignments_on_counting_area_id"
    t.index ["counting_signup_id"], name: "index_area_assignments_on_counting_signup_id"
  end

  create_table "countees", force: :cascade do |t|
    t.bigint "counting_id", null: false
    t.bigint "district_id", null: false
    t.bigint "gender_id"
    t.bigint "age_group_id"
    t.integer "pet_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age_group_id"], name: "index_countees_on_age_group_id"
    t.index ["counting_id"], name: "index_countees_on_counting_id"
    t.index ["district_id"], name: "index_countees_on_district_id"
    t.index ["gender_id"], name: "index_countees_on_gender_id"
  end

  create_table "counting_areas", force: :cascade do |t|
    t.string "name"
    t.geography "geometry", limit: {:srid=>4326, :type=>"multi_polygon", :geographic=>true}, null: false
    t.bigint "counting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["counting_id"], name: "index_counting_areas_on_counting_id"
  end

  create_table "counting_signups", force: :cascade do |t|
    t.bigint "counting_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["counting_id", "user_id"], name: "index_counting_signups_on_counting_id_and_user_id", unique: true
    t.index ["counting_id"], name: "index_counting_signups_on_counting_id"
    t.index ["user_id"], name: "index_counting_signups_on_user_id"
  end

  create_table "countings", force: :cascade do |t|
    t.string "title", null: false
    t.text "description_short"
    t.datetime "starts_at", precision: nil, null: false
    t.datetime "ends_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_countings_on_user_id"
  end

  create_table "districts", force: :cascade do |t|
    t.geography "geometry", limit: {:srid=>4326, :type=>"multi_polygon", :geographic=>true}, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string "label_de"
    t.string "label_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "area_assignments", "counting_areas"
  add_foreign_key "area_assignments", "counting_signups"
  add_foreign_key "countees", "age_groups"
  add_foreign_key "countees", "countings"
  add_foreign_key "countees", "districts"
  add_foreign_key "countees", "genders"
  add_foreign_key "counting_areas", "countings"
  add_foreign_key "counting_signups", "countings"
  add_foreign_key "counting_signups", "users"
  add_foreign_key "countings", "users"
end
