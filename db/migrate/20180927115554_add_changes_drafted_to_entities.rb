class AddChangesDraftedToEntities < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :status, :integer, after: :configuration, default: 2
  end
end
