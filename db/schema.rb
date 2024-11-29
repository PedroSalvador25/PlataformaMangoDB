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

ActiveRecord::Schema[7.2].define(version: 2024_11_29_044911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.string "quality"
    t.decimal "weigth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "plant_id", null: false
    t.boolean "occupied", default: false
    t.index ["plant_id"], name: "index_boxes_on_plant_id"
  end

  create_table "hectares", force: :cascade do |t|
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "community"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plants", force: :cascade do |t|
    t.decimal "humidity"
    t.decimal "growthMm"
    t.decimal "heatJoules"
    t.decimal "steamThicknessMm"
    t.boolean "pestPresence"
    t.string "texture"
    t.decimal "oxygenationLevel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hectare_id", null: false
    t.integer "row", null: false
    t.integer "column", null: false
    t.index ["hectare_id"], name: "index_plants_on_hectare_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.integer "division"
    t.integer "partition"
    t.integer "warehouseId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "box_id"
    t.bigint "warehouse_id"
    t.index ["box_id"], name: "index_shelves_on_box_id"
    t.index ["warehouse_id", "division", "partition"], name: "unique_shelf_positions", unique: true
    t.index ["warehouse_id"], name: "index_shelves_on_warehouse_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "connected", default: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_until"
    t.string "name"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "boxes", "plants"
  add_foreign_key "plants", "hectares"
  add_foreign_key "shelves", "boxes"
  add_foreign_key "shelves", "warehouses"
end
