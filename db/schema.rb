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

ActiveRecord::Schema[7.1].define(version: 2024_01_17_131100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.bigint "opponent_id"
    t.string "topic", null: false
    t.boolean "private", default: false, null: false
    t.boolean "in_progress", default: false, null: false
    t.datetime "achieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_challenges_on_game_id"
    t.index ["opponent_id"], name: "index_challenges_on_opponent_id"
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name", null: false
    t.string "display_name", null: false
    t.string "kana", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_characters_on_game_id"
    t.index ["name"], name: "index_characters_on_name", unique: true
  end

  create_table "dailies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "character_id", null: false
    t.date "tried_on", null: false
    t.integer "round", default: 1, null: false
    t.string "status", default: "ready", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_dailies_on_character_id"
    t.index ["user_id"], name: "index_dailies_on_user_id"
  end

  create_table "daily_challenges", force: :cascade do |t|
    t.bigint "daily_id", null: false
    t.bigint "challenge_id", null: false
    t.integer "success_count", default: 0, null: false
    t.integer "failure_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_daily_challenges_on_challenge_id"
    t.index ["daily_id", "challenge_id"], name: "index_daily_challenges_on_daily_id_and_challenge_id", unique: true
    t.index ["daily_id"], name: "index_daily_challenges_on_daily_id"
  end

  create_table "daily_results", force: :cascade do |t|
    t.bigint "daily_id", null: false
    t.bigint "opponent_id", null: false
    t.integer "win_count", default: 0, null: false
    t.integer "lose_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_id", "opponent_id"], name: "index_daily_results_on_daily_id_and_opponent_id", unique: true
    t.index ["daily_id"], name: "index_daily_results_on_daily_id"
    t.index ["opponent_id"], name: "index_daily_results_on_opponent_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title", null: false
    t.string "abbreviation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "index_games_on_abbreviation", unique: true
    t.index ["title"], name: "index_games_on_title", unique: true
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_notes_on_game_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "username"
    t.string "display_name"
    t.string "email"
    t.string "url"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_user_authentications_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_user_authentications_on_user_id", unique: true
  end

  create_table "user_registrations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_registrations_on_email", unique: true
    t.index ["user_id"], name: "index_user_registrations_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "challenges", "characters", column: "opponent_id"
  add_foreign_key "challenges", "games"
  add_foreign_key "challenges", "users"
  add_foreign_key "characters", "games"
  add_foreign_key "dailies", "characters"
  add_foreign_key "dailies", "users"
  add_foreign_key "daily_challenges", "challenges"
  add_foreign_key "daily_challenges", "dailies"
  add_foreign_key "daily_results", "characters", column: "opponent_id"
  add_foreign_key "daily_results", "dailies"
  add_foreign_key "notes", "games"
  add_foreign_key "notes", "users"
  add_foreign_key "user_authentications", "users"
  add_foreign_key "user_registrations", "users"
end
