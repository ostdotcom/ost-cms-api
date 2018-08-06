class CreatePublishedEntityAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :published_entity_associations do |t|
      t.text :associations
      t.string :environment
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
