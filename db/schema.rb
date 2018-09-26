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

ActiveRecord::Schema.define(version: 20180921054419) do

  create_table "entities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name", null: false
    t.integer "configuration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "entity_data_versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.bigint "entity_id", null: false
    t.bigint "user_id", null: false
    t.text "data", limit: 4294967295, null: false
    t.decimal "order_weight", precision: 55, scale: 20, null: false
    t.integer "status", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id", "status"], name: "entity_status_index"
    t.index ["entity_id"], name: "index_entity_data_versions_on_entity_id"
    t.index ["user_id"], name: "fk_users_table_id"
  end

  create_table "published_entity_associations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.bigint "user_id", null: false
    t.bigint "entity_id", null: false
    t.text "associations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_published_entity_associations_on_entity_id"
    t.index ["user_id"], name: "fk_users_table_id_published"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "uid", null: false
    t.string "provider", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "picture", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "email_UNIQUE", unique: true
  end

  add_foreign_key "entity_data_versions", "entities"
  add_foreign_key "entity_data_versions", "users", name: "fk_users_table_id"
  add_foreign_key "published_entity_associations", "entities"
  add_foreign_key "published_entity_associations", "users", name: "fk_users_table_id_published"
end
