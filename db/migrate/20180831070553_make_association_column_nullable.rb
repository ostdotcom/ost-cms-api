class MakeAssociationColumnNullable < ActiveRecord::Migration[5.1]
  def change
    change_column :published_entity_associations, :associations, :text, null: true
  end
end
