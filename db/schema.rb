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

ActiveRecord::Schema.define(version: 2022_05_04_095551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_enum :item_currency, [
    "usd",
    "eur",
    "uah",
  ], force: :cascade

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "type", null: false
    t.string "brand"
    t.string "model"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.text "dial_color"
    t.text "case_material"
    t.text "case_dimensions"
    t.text "bracelet_material"
    t.text "movement_type"
    t.hstore "features"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.enum "currency", null: false, enum_type: "item_currency"
    t.string "external_id"
    t.string "image_uri"
    t.index ["bracelet_material"], name: "index_items_on_bracelet_material"
    t.index ["brand"], name: "index_items_on_brand"
    t.index ["case_dimensions"], name: "index_items_on_case_dimensions"
    t.index ["case_material"], name: "index_items_on_case_material"
    t.index ["dial_color"], name: "index_items_on_dial_color"
    t.index ["external_id"], name: "index_items_on_external_id", unique: true
    t.index ["model"], name: "index_items_on_model"
    t.index ["movement_type"], name: "index_items_on_movement_type"
    t.index ["price"], name: "index_items_on_price"
  end

end
