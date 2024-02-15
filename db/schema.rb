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

ActiveRecord::Schema[7.1].define(version: 2024_02_15_110228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenge_references", force: :cascade do |t|
    t.bigint "from_id"
    t.bigint "to_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_id", "to_id"], name: "index_challenge_references_on_from_id_and_to_id", unique: true
    t.index ["from_id"], name: "index_challenge_references_on_from_id"
    t.index ["to_id"], name: "index_challenge_references_on_to_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.bigint "character_id"
    t.bigint "opponent_id"
    t.string "topic", null: false
    t.boolean "public", default: true, null: false
    t.boolean "selected", default: false, null: false
    t.datetime "achieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_challenges_on_character_id"
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
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_notes_on_game_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "subject", null: false
    t.text "content", null: false
    t.string "importance", default: "normal", null: false
    t.datetime "released_at"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "play_challenge_results", force: :cascade do |t|
    t.bigint "play_result_id", null: false
    t.bigint "challenge_id", null: false
    t.string "result", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_play_challenge_results_on_challenge_id"
    t.index ["play_result_id", "challenge_id"], name: "idx_on_play_result_id_challenge_id_beb5077770", unique: true
    t.index ["play_result_id"], name: "index_play_challenge_results_on_play_result_id"
  end

  create_table "play_challenges", force: :cascade do |t|
    t.bigint "play_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_play_challenges_on_challenge_id"
    t.index ["play_id", "challenge_id"], name: "index_play_challenges_on_play_id_and_challenge_id", unique: true
    t.index ["play_id"], name: "index_play_challenges_on_play_id"
  end

  create_table "play_results", force: :cascade do |t|
    t.bigint "play_id", null: false
    t.bigint "opponent_id", null: false
    t.string "result", null: false
    t.string "comment", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opponent_id"], name: "index_play_results_on_opponent_id"
    t.index ["play_id"], name: "index_play_results_on_play_id"
  end

  create_table "plays", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "character_id", null: false
    t.datetime "started_at", null: false
    t.string "status", default: "ready", null: false
    t.string "comment", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_plays_on_character_id"
    t.index ["user_id"], name: "index_plays_on_user_id"
  end

  create_table "recipe_situations", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "situation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "situation_id"], name: "index_recipe_situations_on_recipe_id_and_situation_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_situations_on_recipe_id"
    t.index ["situation_id"], name: "index_recipe_situations_on_situation_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.bigint "character_id", null: false
    t.string "movements", null: false
    t.string "comment"
    t.boolean "public", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_recipes_on_character_id"
    t.index ["game_id"], name: "index_recipes_on_game_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "situations", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name", null: false
    t.string "display_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_situations_on_game_id"
    t.index ["name"], name: "index_situations_on_name", unique: true
  end

  create_table "training_results", force: :cascade do |t|
    t.bigint "training_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_training_results_on_training_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.bigint "recipe_id"
    t.bigint "character_id"
    t.string "topic", null: false
    t.boolean "public", default: true, null: false
    t.datetime "achieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_trainings_on_character_id"
    t.index ["game_id"], name: "index_trainings_on_game_id"
    t.index ["recipe_id"], name: "index_trainings_on_recipe_id"
    t.index ["user_id"], name: "index_trainings_on_user_id"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "username"
    t.string "display_name"
    t.string "url"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_user_authentications_on_provider_and_uid", unique: true
    t.index ["provider", "user_id"], name: "index_user_authentications_on_provider_and_user_id", unique: true
  end

  create_table "user_notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "notification_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "public", default: true, null: false
    t.boolean "show_usage", default: true, null: false
    t.boolean "show_tips", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "user_tutorials", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "page", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "page"], name: "index_user_tutorials_on_user_id_and_page", unique: true
    t.index ["user_id"], name: "index_user_tutorials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name"
    t.string "remember_token"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description", default: "", null: false
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "challenge_references", "challenges", column: "from_id"
  add_foreign_key "challenge_references", "challenges", column: "to_id"
  add_foreign_key "challenges", "characters"
  add_foreign_key "challenges", "characters", column: "opponent_id"
  add_foreign_key "challenges", "games"
  add_foreign_key "challenges", "users"
  add_foreign_key "characters", "games"
  add_foreign_key "notes", "games"
  add_foreign_key "notes", "users"
  add_foreign_key "play_challenge_results", "challenges"
  add_foreign_key "play_challenge_results", "play_results"
  add_foreign_key "play_challenges", "challenges"
  add_foreign_key "play_challenges", "plays"
  add_foreign_key "play_results", "characters", column: "opponent_id"
  add_foreign_key "play_results", "plays"
  add_foreign_key "plays", "characters"
  add_foreign_key "plays", "users"
  add_foreign_key "recipe_situations", "recipes"
  add_foreign_key "recipe_situations", "situations"
  add_foreign_key "recipes", "characters"
  add_foreign_key "recipes", "games"
  add_foreign_key "recipes", "users"
  add_foreign_key "situations", "games"
  add_foreign_key "training_results", "trainings"
  add_foreign_key "trainings", "characters"
  add_foreign_key "trainings", "games"
  add_foreign_key "trainings", "recipes"
  add_foreign_key "trainings", "users"
  add_foreign_key "user_authentications", "users"
  add_foreign_key "user_notifications", "notifications"
  add_foreign_key "user_notifications", "users"
  add_foreign_key "user_preferences", "users"
  add_foreign_key "user_tutorials", "users"
end
