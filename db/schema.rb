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

ActiveRecord::Schema.define(version: 20170923194508) do

  create_table "daily_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "player_name"
    t.string   "player_team"
    t.string   "position"
    t.string   "injury_status"
    t.decimal  "minutes",               precision: 4,  scale: 1
    t.decimal  "free_throws_made",      precision: 3,  scale: 1
    t.decimal  "free_throws_attempted", precision: 10
    t.decimal  "free_throw_percentage", precision: 4,  scale: 3
    t.decimal  "rebounds",              precision: 3,  scale: 1
    t.decimal  "assists",               precision: 3,  scale: 1
    t.decimal  "steals",                precision: 3,  scale: 1
    t.decimal  "blocks",                precision: 3,  scale: 1
    t.decimal  "points",                precision: 4,  scale: 1
    t.decimal  "free_throw_value",      precision: 10
    t.decimal  "three_pointer_value",   precision: 10
    t.decimal  "rebounds_value",        precision: 10
    t.decimal  "assists_value",         precision: 10
    t.decimal  "steals_value",          precision: 10
    t.decimal  "blocks_value",          precision: 10
    t.decimal  "points_value",          precision: 10
    t.decimal  "player_value",          precision: 10
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "league_team"
    t.decimal  "three_pointers",        precision: 3,  scale: 1
    t.index ["player_name", "player_team"], name: "index_daily_players_on_player_name_and_player_team", unique: true, using: :btree
  end

  create_table "last_seven_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "player_name"
    t.string   "player_team"
    t.string   "position"
    t.string   "injury_status"
    t.string   "league_team"
    t.decimal  "minutes",               precision: 4,  scale: 2
    t.decimal  "free_throws_made",      precision: 3,  scale: 1
    t.decimal  "free_throws_attempted", precision: 10
    t.decimal  "free_throw_percentage", precision: 4,  scale: 3
    t.decimal  "three_pointers",        precision: 3,  scale: 1
    t.decimal  "rebounds",              precision: 3,  scale: 1
    t.decimal  "assists",               precision: 3,  scale: 1
    t.decimal  "steals",                precision: 3,  scale: 1
    t.decimal  "blocks",                precision: 3,  scale: 1
    t.decimal  "points",                precision: 4,  scale: 1
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "free_throw_value",      precision: 5,  scale: 2
    t.decimal  "three_pointer_value",   precision: 5,  scale: 2
    t.decimal  "rebounds_value",        precision: 5,  scale: 2
    t.decimal  "assists_value",         precision: 5,  scale: 2
    t.decimal  "steals_value",          precision: 5,  scale: 2
    t.decimal  "blocks_value",          precision: 5,  scale: 2
    t.decimal  "points_value",          precision: 5,  scale: 2
    t.decimal  "player_value",          precision: 3,  scale: 1
    t.index ["player_name", "player_team"], name: "index_last_seven_players_on_player_name_and_player_team", unique: true, using: :btree
  end

  create_table "season_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "player_name"
    t.string   "player_team"
    t.string   "position"
    t.string   "injury_status"
    t.string   "league_team"
    t.decimal  "minutes",               precision: 4,  scale: 2
    t.decimal  "free_throws_made",      precision: 3,  scale: 1
    t.decimal  "free_throws_attempted", precision: 10
    t.decimal  "free_throw_percentage", precision: 4,  scale: 3
    t.decimal  "three_pointers",        precision: 3,  scale: 1
    t.decimal  "rebounds",              precision: 3,  scale: 1
    t.decimal  "assists",               precision: 3,  scale: 1
    t.decimal  "steals",                precision: 3,  scale: 1
    t.decimal  "blocks",                precision: 3,  scale: 1
    t.decimal  "points",                precision: 4,  scale: 1
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "free_throw_value",      precision: 10
    t.decimal  "three_pointer_value",   precision: 10
    t.decimal  "rebounds_value",        precision: 10
    t.decimal  "assists_value",         precision: 10
    t.decimal  "steals_value",          precision: 10
    t.decimal  "blocks_value",          precision: 10
    t.decimal  "points_value",          precision: 10
    t.decimal  "player_value",          precision: 3,  scale: 1
    t.index ["player_name", "player_team"], name: "index_season_players_on_player_name_and_player_team", unique: true, using: :btree
  end

  create_table "trades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "date"
    t.time     "time"
    t.string   "team_name_out"
    t.string   "player_traded"
    t.string   "team_name_in"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "date"
    t.string   "team_name"
    t.string   "action"
    t.string   "player_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
