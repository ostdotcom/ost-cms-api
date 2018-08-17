module DbService
  class Rollback < Base

    include ::Util::ResultHelper

    def initialize(params, user)
      super(params, user)
    end

    def perform
      return handle_rollback
    end

    private

    def handle_rollback
      data = @params
      @entity_id =  data["entity_id"]
      if get_published_count > 1
        set_entity_status_from_published_table(get_last_published, 2)
        get_last_published.destroy
        set_entity_status_from_published_table(get_last_published, 1)
        success
      else
        error_with_data(
            'last_record',
            'This is last record, can not be deleted',
            'This is last record, can not be deleted',
            GlobalConstant::ErrorAction.default,
            {},
            {},
            GlobalConstant::ErrorCode.bad_request
        )
      end
    end


    def get_last_published
      PublishedEntityAssociation.where(entity_id: @entity_id).last
    end


    def get_published_count
      PublishedEntityAssociation.where(entity_id: @entity_id).count
    end

    def set_entity_status_from_published_table(published_record, status)
      EntityDataVersion.where(id: published_record.associations).each do |entity|
        entity.status = status
        entity.save
      end if published_record

    end

  end
end