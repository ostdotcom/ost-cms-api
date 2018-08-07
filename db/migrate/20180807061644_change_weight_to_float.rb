class ChangeWeightToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :entity_data_versions, :order_weight, :float
  end
end
