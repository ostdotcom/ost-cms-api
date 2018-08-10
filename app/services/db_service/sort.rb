module DbService
  class Sort < Base

    def initialize(params)
      super(params)
    end

    def perform
      data = @params
      id = data["id"]
      entity_id = data["entity_id"]
      prev_id,  next_id= data["prev"],  data["next"]
      entity = EntityDataVersion.find_by_id(id)


      if prev_id && next_id
        prev_entity = EntityDataVersion.where([  "id = '"+prev_id+"'" ,"status = '0'", "entity_id = '"+ entity_id +"'"]).first
        next_entity = EntityDataVersion.where([  "id = '"+next_id+"'" ,"status = '0'", "entity_id = '"+ entity_id +"'"]).first
        order_weight = (prev_entity.order_weight + next_entity.order_weight) / 2

      elsif prev_id
        prev_entity = EntityDataVersion.where([  "id = '"+prev_id+"'" ,"status = '0'", "entity_id = '"+ entity_id +"'"]).first
        order_weight = prev_entity.order_weight * 2

      elsif next_id
        next_entity = EntityDataVersion.where([  "id = '"+next_id+"'" ,"status = '0'", "entity_id = '"+ entity_id +"'"]).first
        order_weight = next_entity.order_weight / 2
      end
      entity.order_weight = order_weight
      entity.save
      success
    end


  end
end