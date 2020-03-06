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

ActiveRecord::Schema.define(version: 2020_03_06_042431) do

  create_table "chirps", force: :cascade do |t|
    t.integer "author_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_chirps_on_author_id"
  end

  create_table "chirps_users", id: false, force: :cascade do |t|
    t.integer "chirp_id", null: false
    t.integer "user_id", null: false
    t.index ["chirp_id", "user_id"], name: "index_chirps_users_on_chirp_id_and_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "friend_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id"], name: "index_follows_on_follower_id"
    t.index ["friend_id"], name: "index_follows_on_friend_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "chirps", "users", column: "author_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "follows", "users", column: "friend_id"
end
