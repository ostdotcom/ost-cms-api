class ChangeOrderWeightToBeDecimalInEntityDataVersions < ActiveRecord::Migration[5.1]
  def change
    change_column :entity_data_versions, :order_weight, :decimal, precision: 55, scale: 20, null: false
  end
end
