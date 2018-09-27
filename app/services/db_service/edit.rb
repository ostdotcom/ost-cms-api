module DbService
  class Edit < Base

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
      delete_entity_data(data["id"])
      data.delete("id")
      data.delete("entity_name")
      created_record = EntityDataVersion.create!(data: data, order_weight: @copied_entity[:order_weight], entity_id: @copied_entity[:entity_id], status: 0,  user_id: @user_id)
      change_draft_status(true)
      success_with_data(created_record.data)
    end

    def delete_entity_data(id)
      @copied_entity = EntityDataVersion.find_by_id(id)
      @copied_entity.status = 2
      @copied_entity.save!
      success
    end


  end
end