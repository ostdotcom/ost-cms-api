module DbService
  class ResetToPublish < Base

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
      if published_record_associations.present? && are_changes_drafted?
        entities = EntityDataVersion
                       .where(status: 0)
                       .where(entity_id: @entity.id)
                       .order(:order_weight)

        entities.each do |entity|
          entity.status = 2
          entity.save!
          ordered_array.push(entity.id)
          ordered_data_array.push(entity.data)
        end

        EntityDataVersion.where(id: @published_record_associations).each do |entity|
          entity.status = 1
          entity.save
        end
        success
      else
        error_with_data("no_published_data", "", "Nothing to reset","",{},{}, http_code = GlobalConstant::ErrorCode.bad_request )
      end
    end

    def published_record_associations
      @published_record = PublishedEntityAssociation.where(entity_id: @entity.id).last
      @published_record_associations =  @published_record.present? ? @published_record.associations : []
    end

    def are_changes_drafted?
      EntityDataVersion.where(id: @published_record_associations).where(entity_id: @entity.id).each do |entity|
        if entity.status != 1
          return true
        end
      end
      EntityDataVersion.where.not(id: @published_record_associations).where(entity_id: @entity.id).each do |entity|
        if entity.status != 2
          return true
        end
      end
      false

    end


  end
end
