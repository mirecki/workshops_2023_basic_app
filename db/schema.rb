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

ActiveRecord::Schema[7.0].define(version: 2023_05_26_221743) do
  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_loans", force: :cascade do |t|
    t.string "status", default: "checked_out"
    t.datetime "due_date", precision: nil
    t.integer "book_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_id"
    t.index ["book_id"], name: "index_book_loans_on_book_id"
    t.index ["user_id"], name: "index_book_loans_on_user_id"
  end

  create_table "book_reservations", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.integer "book_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_reservations_on_book_id"
    t.index ["user_id"], name: "index_book_reservations_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "isbn"
    t.integer "year"
    t.integer "page_count"
    t.date "published_on"
    t.string "language"
    t.integer "author_id", null: false
    t.integer "category_id", null: false
    t.integer "publisher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_loans", "books"
  add_foreign_key "book_loans", "users"
  add_foreign_key "book_reservations", "books"
  add_foreign_key "book_reservations", "users"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "publishers"
end
