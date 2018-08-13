class IntialSchema < ActiveRecord::Migration[5.1]

  def up

    create_table "entities", force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "name", unique: true
    end

    create_table "entity_data_versions", force: :cascade do |t|
      t.bigint "entity_id", null: false
      t.bigint "user_id", null: false
      t.text "data", limit: 4294967295, null: false
      t.float "order_weight", limit: 24, null: false
      t.integer "status", limit: 1, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["entity_id", "status"], name: "entity_status_index"
      t.index ["entity_id"], name: "index_entity_data_versions_on_entity_id"
      t.index ["user_id"], name: "fk_users_table_id"
    end

    create_table "published_entity_associations", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "entity_id", null: false
      t.text "associations", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["entity_id"], name: "index_published_entity_associations_on_entity_id"
      t.index ["user_id"], name: "fk_users_table_id_published"
    end

    create_table "users", force: :cascade do |t|
      t.string "uid", null: false
      t.string "provider", null: false
      t.string "email", null: false
      t.string "first_name", null: false
      t.string "last_name", null: false
      t.string "picture", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "email_UNIQUE", unique: true
    end

    add_foreign_key "entity_data_versions", "entities"
    add_foreign_key "entity_data_versions", "users", name: "fk_users_table_id"
    add_foreign_key "published_entity_associations", "entities"
    add_foreign_key "published_entity_associations", "users", name: "fk_users_table_id_published"

  end

  def down
    drop_table "entities"
    drop_table "entity_data_versions"
    drop_table "published_entity_associations"
    drop_table "users"
  end
end
