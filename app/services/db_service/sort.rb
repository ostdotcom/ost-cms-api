module DbService
  class Sort < Base

    def initialize(params, user)
      super(params, user)
    end

    def perform
      data = @params
      id = data["id"]
      entity_id = data["entity_id"]
      prev_id,  next_id= data["prev"],  data["next"]
      entity = EntityDataVersion.find_by_id(id)
      prev_entity = EntityDataVersion
                        .where(id: prev_id)
                        .where(status: 0)
                        .where(entity_id: entity_id)
      next_entity = EntityDataVersion
                        .where(id: next_id)
                        .where(status: 0)
                        .where(entity_id: entity_id)


      if prev_entity.present? && next_entity.present?
        order_weight = (prev_entity.first.order_weight + next_entity.first.order_weight) / 2

      elsif prev_entity.present?
        order_weight = prev_entity.first.order_weight * 2

      elsif next_entity.present?
        order_weight = next_entity.first.order_weight / 2
      end
      entity.order_weight = order_weight
      entity.save
      success
    end


  end
end