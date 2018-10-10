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
      published_entity_association_count = PublishedEntityAssociation.where(entity_id: @entity.id).count
      if entity_status == GlobalConstant::Models::Entity.previewed
        entity_data_versions = EntityDataVersion
                       .where(status: [GlobalConstant::Models::EntityDataVersion.draft, GlobalConstant::Models::EntityDataVersion.active])
                       .where(entity_id: @entity.id)
                       .order(:order_weight)

        entity_data_versions.each do |edv|
          edv.status = GlobalConstant::Models::EntityDataVersion.active
          edv.save!
          ordered_array.push(edv.id)
          ordered_data_array.push(edv.data)
        end
        json_data = JSON:: dump ordered_data_array
        Aws::S3Manager.new.store(GlobalConstant::Aws.json_file_upload_path + @entity.name + '.json', json_data,
                                 GlobalConstant::Aws.bucket, "application/json; charset=utf-8")
        PublishedEntityAssociation.create!(associations: ordered_array, entity_id: @entity.id, user_id: @user_id)
        change_entity_status(GlobalConstant::Models::Entity.published)
        return success
      elsif entity_status == GlobalConstant::Models::Entity.published || (entity_status == GlobalConstant::Models::Entity.draft && published_entity_association_count == 0)
        return error_with_data('nothing_to_publish', '', 'There is nothing to publish', '',{}, {}, GlobalConstant::ErrorCode.bad_request)
      elsif entity_status == GlobalConstant::Models::Entity.draft
        return error_with_data('preview_before_publish', '', 'Please Preview the changes before publishing', '',{}, {}, GlobalConstant::ErrorCode.bad_request)
      else
        return error_with_data('nothing_to_publish', '', 'There is nothing to publish', '',{}, {}, GlobalConstant::ErrorCode.bad_request)
      end
  end
  end
end