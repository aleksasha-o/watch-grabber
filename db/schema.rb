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

ActiveRecord::Schema.define(version: 2022_03_15_135723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.decimal "price", precision: 10, scale: 2
    t.string "currency"
    t.text "dial_color"
    t.text "case_material"
    t.text "case_dimensions"
    t.text "bracelet_material"
    t.text "movement_type"
    t.text "box_and_papers"
    t.integer "year"
    t.string "gender"
    t.text "condition"
    t.string "regular_price"
    t.text "papers"
    t.text "box"
    t.text "crystal"
    t.text "caseback"
    t.text "power_reserve"
    t.text "lug_width"
    t.text "bezel_material"
    t.text "manual"
    t.text "max_wrist_size"
    t.text "case_thickness"
    t.text "water_resistance"
    t.text "reference_number"
    t.text "functions"
    t.text "manufactured"
    t.text "lume"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
