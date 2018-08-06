class AddEntityToPublishedEntityAssociations < ActiveRecord::Migration[5.1]
  def change
    add_reference :published_entity_associations, :entity, foreign_key: true
  end
end
