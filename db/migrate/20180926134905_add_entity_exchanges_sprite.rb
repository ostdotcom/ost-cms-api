class AddEntityExchangesSprite < ActiveRecord::Migration[5.1]
  def up
    Entity.create_with( configuration: '2').find_or_create_by(:name => 'exchanges_sprite')
  end

  def down
    entity = Entity.find_by_name( 'exchanges_sprite' )
    entity.destroy
  end
end
