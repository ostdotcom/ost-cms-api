class AddEntityPartnersSprite < ActiveRecord::Migration[5.1]
  def up
    Entity.create_with( configuration: '2').find_or_create_by(:name => 'partners_sprite')
  end

  def down
    entity = Entity.find_by_name( 'partners_sprite' )
    entity.destroy
  end
end
