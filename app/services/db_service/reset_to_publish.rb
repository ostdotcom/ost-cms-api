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
      data = @params
      data.delete("entity_name")
      if published_record_associations.present? && @entity.present? && @entity.status != :published
        entities = EntityDataVersion
                       .where(status: [0, 1])
                       .where(entity_id: @entity.id)
                       .order(:order_weight)

        entities.each do |edv|
          edv.status = 2
          edv.save!
        end

        EntityDataVersion.where(id: @published_record_associations).order("FIELD(id, #{@published_record_associations.reverse.join ', '})").each do |edv|
          edv.status = 1
          edv.order_weight = OrderWeights.new.get_new_record_weight(@entity.id)
          edv.save
        end
        change_entity_status(:published)
        success
      else
        error_with_data("no_published_data", "", "Nothing to reset","",{},{}, http_code = GlobalConstant::ErrorCode.bad_request )
      end
    end

    def published_record_associations
      @published_record = PublishedEntityAssociation.where(entity_id: @entity.id).last
      @published_record_associations =  @published_record.present? ? @published_record.associations : []
    end

  end
end
