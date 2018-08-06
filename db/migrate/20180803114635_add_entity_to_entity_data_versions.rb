class AddEntityToEntityDataVersions < ActiveRecord::Migration[5.1]
  def change
    add_reference :entity_data_versions, :entity, foreign_key: true, index:true
  end
end
