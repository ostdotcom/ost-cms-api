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
      data.delete("id")
      data.delete("entity_name")
      if  only_one_record_allowed? && data_exists?
        error_with_data("max_one_record_allowed", "","Maximum one record is allowed to add", "", {}, {}, GlobalConstant::ErrorCode.bad_request)
      else
        weight = OrderWeights.new.get_new_record_weight(@entity.id)
        created_record = EntityDataVersion.create!(data: data, order_weight: weight, entity_id: @entity.id, status: 0, user_id: @user_id)
        success_with_data(created_record.data)

      end
    end


  end
end