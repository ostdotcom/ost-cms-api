module DbService
  class Sort < Base

    def initialize(params, user)
      super(params, user)
    end

    def perform
      return handle_data
    end

    private

    def handle_data
      data = @params
      id = data["id"]
      entity_id = data["entity_id"]
      prev_id,  next_id = data["prev"],  data["next"]
      entity = EntityDataVersion.find_by_id(id)
      order_weight = entity.order_weight
      prev_entity = EntityDataVersion
                        .where(id: prev_id)
                        .where(status: [0,1])
                        .where(entity_id: entity_id) if prev_id.present?
      next_entity = EntityDataVersion
                        .where(id: next_id)
                        .where(status: [0,1])
                        .where(entity_id: entity_id) if next_id.present?


      if prev_entity.present? && next_entity.present?
        order_weight = (prev_entity.first.order_weight + next_entity.first.order_weight) / 2.0
      elsif prev_entity.present?
        order_weight = prev_entity.first.order_weight * (10.0 / 9.0)
      elsif next_entity.present?
        order_weight = next_entity.first.order_weight * (9.0 / 10.0)
      end
      entity.order_weight = order_weight
      entity.save!
      success
    end


  end
end