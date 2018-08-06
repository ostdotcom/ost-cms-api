class CreateEntityDataVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :entity_data_versions do |t|
      t.string :data
      t.decimal :order_weight
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end
