class AddStatusToEntityDataVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :entity_data_versions,  :status, :integer
  end
end
