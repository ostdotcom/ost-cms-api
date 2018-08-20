module DbService
  class Delete < Base

    include ::Util::ResultHelper

    def initialize(params, user)
      super(params, user)
    end

    def perform
      return handle_data
    end

    private

    def handle_data
      entity_to_delete = EntityDataVersion.find_by_id(@params["id"])
      entity_to_delete.status = 2
      entity_to_delete.save!
      success
    end

  end
end