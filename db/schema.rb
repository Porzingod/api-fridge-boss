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

ActiveRecord::Schema.define(version: 2018_04_28_153359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.date "expiration_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "recipe_cuisines", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "cuisine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_recipe_cuisines_on_cuisine_id"
    t.index ["recipe_id"], name: "index_recipe_cuisines_on_recipe_id"
  end

  create_table "recipe_ingredient_joins", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "recipe_ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_ingredient_joins_on_recipe_id"
    t.index ["recipe_ingredient_id"], name: "index_recipe_ingredient_joins_on_recipe_ingredient_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipeName"
    t.string "recipeId"
    t.string "smallImageUrls"
    t.integer "totalTimeInSeconds"
    t.string "ingredients"
    t.string "cuisines_list"
  end

  create_table "user_recipes", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "user_id"
    t.index ["recipe_id"], name: "index_user_recipes_on_recipe_id"
    t.index ["user_id"], name: "index_user_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ingredients", "users"
  add_foreign_key "recipe_cuisines", "cuisines"
  add_foreign_key "recipe_cuisines", "recipes"
  add_foreign_key "recipe_ingredient_joins", "recipe_ingredients"
  add_foreign_key "recipe_ingredient_joins", "recipes"
  add_foreign_key "user_recipes", "recipes"
  add_foreign_key "user_recipes", "users"
end
