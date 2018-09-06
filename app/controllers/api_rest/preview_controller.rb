module ApiRest
  class PreviewController < ApiRest::MainController

    def get_data
      params[:name] = params[:entity].to_s.split('.')[0].to_s
      service_response = DbService::Get.new(params).get_active_by_name
      # NOTE: Response is custom to match the JSON file uploaded on S3
      if service_response.success?
        lists = service_response.data[:list]
        response = lists.map {|list| list[:record] }
        (render plain: Oj.dump(response, mode: :compat), status: GlobalConstant::ErrorCode.ok)
      else
        (render plain: Oj.dump([], mode: :compat), status: GlobalConstant::ErrorCode.ok)
      end
    end

  end
end