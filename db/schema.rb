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

ActiveRecord::Schema.define(version: 2023_01_02_161429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "companiables", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "company_id"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companiables_on_company_id"
    t.index ["game_id"], name: "index_companiables_on_game_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "company_type"
    t.string "name"
    t.string "slug"
    t.string "url"
    t.string "city"
    t.string "country"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "url"
    t.integer "status", default: 0
    t.string "plot"
    t.string "short_plot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_games_on_slug", unique: true
  end

  create_table "games_genres", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "genre_id", null: false
    t.index ["game_id", "genre_id"], name: "index_games_genres_on_game_id_and_genre_id"
  end

  create_table "genres", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_genres_on_slug", unique: true
  end

  create_table "platforms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "abbrv_name"
    t.string "url"
    t.bigint "manufactur_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufactur_id"], name: "index_platforms_on_manufactur_id"
    t.index ["slug"], name: "index_platforms_on_slug", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "auth_tokens"
  end

  add_foreign_key "companiables", "companies"
  add_foreign_key "companiables", "games"
end
