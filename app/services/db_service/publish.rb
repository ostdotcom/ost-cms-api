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
      success
    end


  end
end