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

ActiveRecord::Schema[7.0].define(version: 2022_04_18_072952) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "token"
    t.string "renew_token"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "genre_id", null: false
    t.index "to_tsvector('english'::regconfig, (title)::text)", name: "index_articles_on_to_tsvector_english_title", using: :gin
    t.index ["genre_id"], name: "index_articles_on_genre_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_assets_on_ancestry"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "book_id", null: false
    t.index ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id"
    t.index ["book_id", "author_id"], name: "index_authors_books_on_book_id_and_author_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "to_tsvector('english'::regconfig, (name)::text)", name: "index_genres_on_to_tsvector_english_name", using: :gin
  end

  create_table "groups", force: :cascade do |t|
    t.string "group_role"
    t.string "group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_roles", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "role_id", null: false
  end

  create_table "lol_champions", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "quote"
    t.string "summoner_spell"
    t.bigint "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_id"], name: "index_lol_champions_on_tree_id"
  end

  create_table "media_conans", force: :cascade do |t|
    t.string "character"
    t.string "gadget"
    t.string "vehicle"
    t.bigint "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_id"], name: "index_media_conans_on_tree_id"
  end

  create_table "media_one_pieces", force: :cascade do |t|
    t.string "character"
    t.string "sea"
    t.string "location"
    t.string "quote"
    t.string "skill"
    t.bigint "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_id"], name: "index_media_one_pieces_on_tree_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "nurse_schedules", force: :cascade do |t|
    t.boolean "booked", default: false
    t.bigint "schedule_id", null: false
    t.bigint "nurse_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nurse_id", "schedule_id"], name: "index_nurse_schedules_on_nurse_id_and_schedule_id", unique: true
    t.index ["nurse_id"], name: "index_nurse_schedules_on_nurse_id"
    t.index ["schedule_id"], name: "index_nurse_schedules_on_schedule_id"
  end

  create_table "nurses", force: :cascade do |t|
    t.string "name"
    t.bigint "phone"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_pets", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "move"
    t.bigint "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_id"], name: "index_pokemon_pets_on_tree_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string "time_start"
    t.string "time_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "area"
    t.string "match"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match"], name: "index_tickets_on_match"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "trees", force: :cascade do |t|
    t.string "name"
    t.string "parent_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_trees_on_name"
    t.index ["parent_path"], name: "index_trees_on_parent_path"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "username"
    t.bigint "group_id", null: false
    t.index ["email"], name: "index_users_on_email", opclass: :text_pattern_ops
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["status_id"], name: "index_users_on_status_id"
    t.index ["username"], name: "index_users_on_username", opclass: :gist_trgm_ops, using: :gist
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "genres"
  add_foreign_key "lol_champions", "trees"
  add_foreign_key "media_conans", "trees"
  add_foreign_key "media_one_pieces", "trees"
  add_foreign_key "messages", "users"
  add_foreign_key "nurse_schedules", "nurses"
  add_foreign_key "nurse_schedules", "schedules"
  add_foreign_key "pokemon_pets", "trees"
  add_foreign_key "tickets", "users"
  add_foreign_key "users", "groups"
  add_foreign_key "users", "statuses"
end
