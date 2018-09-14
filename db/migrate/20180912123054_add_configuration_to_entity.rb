class AddConfigurationToEntity < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :configuration, :integer
  end
end
