module DbService
  class Get < Base

    include ::Util::ResultHelper

    def initialize(params)
      super(params)
    end

    def get_published
      published_list = []
      data = @params
      entity_id = data["entity_id"]
      published_data = PublishedEntityAssociation.where(entity_id: entity_id).last
      EntityDataVersion.where(id: published_data.associations).order(:order_weight).each do |entity|
        published_list.push({record: entity.data, id: entity.id})
      end if published_data
      success_with_data({entity_id: entity_id, list: published_list})
    end

    def get_active_by_name
      entity = Entity.where(name: @params[:name]).first
      if entity.present?
        @params["entity_id"] = entity.id
        get_active_by_id
      else
        error_with_data(
            'no_record_found',
            'No record found',
            'No record found',
            GlobalConstant::ErrorAction.default,
            {},
            {},
            GlobalConstant::ErrorCode.bad_request
        )
      end
    end

    def get_active_by_id
      active_list = []
      data = @params
      entity_id = data["entity_id"]
      entities = EntityDataVersion
                     .where(status: [0, 1])
                     .where(entity_id: entity_id)
                     .order(:order_weight)
      entities.each do |entity|
        active_list.push({id: entity.id, record: entity.data})
      end
      success_with_data({entity_id: entity_id, list: active_list})
    end

    def get_record
      data = @params
      id = data["id"]
      record = EntityDataVersion.where(id: id).first
      if record
        success_with_data({id: id, record: record.data})
      else
        error_with_data(
            'no_record_found',
            'No record found',
            'No record found',
            GlobalConstant::ErrorAction.default,
            {},
            {},
            GlobalConstant::ErrorCode.bad_request
        )
      end
    end

  end
end