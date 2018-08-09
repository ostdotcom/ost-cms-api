module DbService
  class Create < Base

    include ::Util::ResultHelper

    def initialize(params)
      super(params)
      puts params
    end

    def perform
      r = validate
      if ! r.success?
        return r
      end
      data = @params
      entity_id =  data["entity_id"]
      data.delete("id")
      data.delete("entity_id")
      weight = OrderWeights.new.get_new_record_weight(entity_id)
      created_record = EntityDataVersion.create(data: data, order_weight:weight, entity_id: entity_id, status: 0)
      success_with_data(created_record.data)
    end


  end
end