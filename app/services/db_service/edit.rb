module DbService
  class Edit < Base

    include ::Util::ResultHelper

    def initialize(params, user)
      super(params, user)
    end

    def perform
      r = validate
      if ! r.success?
        return r
      end
      data = @params
      id = data["id"]
      data.delete("id")
      data.delete("entity_id")
      entity = EntityDataVersion.find_by_id(id)
      entity.status = 2
      entity.save
      created_record = EntityDataVersion.create(data: data, order_weight: entity[:order_weight], entity_id: entity[:entity_id], status: 0,  user_id: @user_id)
      success_with_data(created_record.data)
    end


  end
end