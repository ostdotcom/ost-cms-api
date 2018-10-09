module DbService
  class Publish < Base

    include ::Util::ResultHelper

    def initialize(params, user)
      super(params, user)
    end

    def perform
      return handle_data
    end

    private

    def handle_data
      ordered_array, ordered_data_array = [], []
      data = @params
      data.delete("entity_name")
      entity_status = @entity.status
      if entity_status == 3
        entities = EntityDataVersion
                       .where(status: [0,1])
                       .where(entity_id: @entity.id)
                       .order(:order_weight)

        entities.each do |entity|
          entity.status = 1
          entity.save!
          ordered_array.push(entity.id)
          ordered_data_array.push(entity.data)
        end
        json_data = JSON:: dump ordered_data_array
        Aws::S3Manager.new.store(GlobalConstant::Aws.json_file_upload_path + @entity.name + '.json', json_data,
                                 GlobalConstant::Aws.bucket, "application/json; charset=utf-8")
        PublishedEntityAssociation.create!(associations: ordered_array, entity_id: @entity.id, user_id: @user_id)
        change_entity_status(2)
        return success
      elsif entity_status == 2
        return error_with_data('nothing_to_publish', '', 'There is nothing to publish', '',{}, {}, GlobalConstant::ErrorCode.bad_request)
      elsif entity_status == 1
        return error_with_data('preview_before_publish', '', 'Please Preview the changes before publishing', '',{}, {}, GlobalConstant::ErrorCode.bad_request)
      end
  end
  end
end