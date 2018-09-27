class AddChangesDraftedToEntities < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :changes_drafted, :boolean, after: :configuration, default: false
  end
end
