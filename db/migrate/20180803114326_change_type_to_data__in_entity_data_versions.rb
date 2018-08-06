class ChangeTypeToDataInEntityDataVersions < ActiveRecord::Migration[5.1]
  def change
    change_column :entity_data_versions, :data, :longtext
  end
end
