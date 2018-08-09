module DbService
  class Publish < Base

    include ::Util::ResultHelper

    def initialize(params)
      super(params)
      puts params
    end

    def perform
      validate
      data = @params
      entity_id =  data["entity_id"]
      data.delete("entity_id")
      entities = EntityDataVersion.where(["status = '0'", "entity_id = '"+ entity_id +"'"]).order(:order_weight)
      ordered_array = []
      entities.each do |entity|
        ordered_array.push(entity.id)
      end
      PublishedEntityAssociation.create(associations: ordered_array, environment:"DEV", entity_id:entity_id)
      success
    end


  end
end