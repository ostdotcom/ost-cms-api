module DbService
  class Publish < Base

    include ::Util::ResultHelper

    def initialize(params, user)
      super(params, user)
    end

    def perform
      validate
      data = @params
      entity_id =  data["entity_id"]
      data.delete("entity_id")
      entities = EntityDataVersion
                     .where(status: [0,1])
                     .where(entity_id: entity_id)
                     .order(:order_weight)
      ordered_array = []
      entities.each do |entity|
        entity.status = 1
        entity.save
        ordered_array.push(entity.id)
      end
      PublishedEntityAssociation.create(associations: ordered_array, entity_id:entity_id, user_id: @user_id)
      success
    end


  end
end