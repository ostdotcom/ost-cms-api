module DbService
  class Create < Base

    include ::Util::ResultHelper

    def initialize(params, user)
      super(params, user)
    end

    def perform
      r = validate
      return r unless r.success?
      return handle_data
    end

    private

    def handle_data
      data = @params
      entity_id =  data["entity_id"]
      data.delete("id")
      data.delete("entity_id")
      weight = OrderWeights.new.get_new_record_weight(entity_id)
      puts "===================================================="
      puts weight
      created_record = EntityDataVersion.create!(data: data, order_weight: weight, entity_id: entity_id, status: 0, user_id: @user_id)
      success_with_data(created_record.data)
    end

  end
end