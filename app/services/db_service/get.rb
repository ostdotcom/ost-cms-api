module DbService
  class Get < Base

    include ::Util::ResultHelper

    def initialize(params)
      super(params)
    end

    def get_published
      published_list = []
      published_data = PublishedEntityAssociation.where(entity_id: @entity.id).last
      associations = published_data.associations
      EntityDataVersion.where(id: associations).order("FIELD(id, #{associations.join ', '})").each do |entity|
        published_list.push({record: entity.data, id: entity.id})
      end if published_data
      success_with_data({entity_id: @entity.id, list: published_list})
    end

    def get_active_by_name
      @params["entity_name"] = @params[:name]
      @entity = Entity.where(name: @params["entity_name"]).first
      if @entity.present?
        get_active
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

    def get_active
      active_list = []
      data = @params
      entities = EntityDataVersion
                     .where(status: [0, 1])
                     .where(entity_id: @entity.id)
                     .order(:order_weight)
      entities.each do |entity|
        active_list.push({id: entity.id, record: entity.data})
      end
      success_with_data({entity_id: @entity.id, list: active_list})
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