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
        set_entity_status_from_published_table(get_last_published, 0)
        get_last_published.destroy
        set_entity_status_from_published_table(get_last_published, 1)

        get_published_records

        upload_to_s3

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

    def get_published_records
      published_record = []
      get_last_published.associations.each do |record|
        record = EntityDataVersion.find_by_id(record)
        published_record.push(record.data)
      end
      @published_record = published_record
    end

    def upload_to_s3
      json_data = JSON:: dump @published_record
      entity = Entity.find_by_id(@entity_id)

      Aws::S3Manager.new.store(GlobalConstant::Aws.json_file_upload_path + entity.name + '.json', json_data,
                               GlobalConstant::Aws.bucket, "application/json; charset=utf-8")
    end

  end
end