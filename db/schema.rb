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

ActiveRecord::Schema.define(version: 20180528180804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "vote_count"
    t.integer  "lab_id"
    t.integer  "hypothesis_id"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dislikes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "hypothesis_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "lab_id"
    t.integer  "question_id"
  end

  create_table "downvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "question_id"
    t.integer  "hypothesis_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "lab_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "hypotheses", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "lab_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "parent"
    t.integer  "question_id"
    t.integer  "review_id"
    t.integer  "tag_id"
    t.integer  "group_id"
  end

  create_table "lab_files", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "lab_id"
    t.string   "hypothesis_id"
    t.string   "integer"
    t.string   "question_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "labs", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "parent"
    t.integer  "question_id"
    t.integer  "hypothesis_id"
    t.integer  "tag_id"
    t.integer  "group_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "hypothesis_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "lab_id"
    t.integer  "question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "lab_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "parent"
    t.integer  "hypothesis_id"
    t.integer  "tag_id"
    t.integer  "group_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "hypothesis_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.string   "category"
    t.integer  "rank"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "lab_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "hypothesis_id"
    t.integer  "question_id"
  end

  create_table "upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "question_id"
    t.integer  "hypothesis_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "lab_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.integer  "group_id"
    t.integer  "requested_group"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
