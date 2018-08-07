module DbService
  class Get < Base

    def initialize(params)
      super(params)
      puts params
    end

    def get_published
      published_list = []
      data = @params
      entity_id = data["entity_id"]
      published_data = PublishedEntityAssociation.where("entity_id = '"+ entity_id +"'").last
      published_data.associations.each do |element|
        entity = EntityDataVersion.where( "id = '"+ element.to_s() +"'").first
        published_list.push({record: entity.data, id:entity.id})
      end
      Result::Base.success(data:published_list)
    end

    def get_active
      active_list = []
      data = @params
      entity_id = data["entity_id"]
      entities = EntityDataVersion.where(["status = '0'","entity_id = '"+ entity_id +"'"])
      entities.each do |entity|
        active_list.push({id: entity.id, record: entity.data})
      end
      Result::Base.success(data:active_list)
    end


  end
end