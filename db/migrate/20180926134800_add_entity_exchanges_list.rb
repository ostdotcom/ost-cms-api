class AddEntityExchangesList < ActiveRecord::Migration[5.1]
  def up
    Entity.create_with( configuration: '1').find_or_create_by(:name => 'exchanges_list')
  end

  def down
    entity = Entity.find_by_name( 'exchanges_list' )
    entity.destroy
  end
end
