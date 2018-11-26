class AddEntityHomePageJumbotron < ActiveRecord::Migration[5.1]
  def up
    Entity.create_with( configuration: '2').find_or_create_by(:name => 'home_page_jumbotron')
  end

  def down
    entity = Entity.find_by_name( 'home_page_jumbotron' )
    entity.destroy
  end
end
