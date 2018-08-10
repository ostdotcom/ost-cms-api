module DbService
  class Sort < Base

    def initialize(params)
      super(params)
      puts params
    end

    def perform
      data = @params
      id = data["id"]
      entity_id = data["entity_id"]
      prev_id,  next_id= data["prev"],  data["next"]
      prev_entity, next_entity = nil, nil
      entity = EntityDataVersion.find_by_id(id)
      if prev_id
        prev_entity = EntityDataVersion.where([  "id = '"+prev_id+"'" ,"status = '0'", "entity_id = '"+ entity_id +"'"]).first
      end
      if next_id
        next_entity = EntityDataVersion.where([  "id = '"+next_id+"'" ,"status = '0'", "entity_id = '"+ entity_id +"'"]).first
      end
      if ! next_entity
        next_entity = EntityDataVersion.where([  "order_weight > "+ prev_entity.order_weight  ,"status = '0'", "entity_id = '"+ entity_id +"'"]).order(:order_weight).first
      elsif ! prev_entity
        prev_entity = EntityDataVersion.where([  "order_weight < "+ next_entity.order_weight  ,"status = '0'", "entity_id = '"+ entity_id +"'"]).order(:order_weight).last
      end
      order_weight = (prev_entity.order_weight + next_entity.order_weight) / 2

      entity.order_weight = order_weight
      entity.save
      success
    end


  end
end