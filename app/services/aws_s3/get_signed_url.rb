module AwsS3

  class GetSignedUrl

    include ::Util::ResultHelper

    def initialize(params)
      @params = params
    end

    def perform
      if ! validate
        return error_with_data('swr', 'Unsupported image type', 'File type is not supported' ,'swr',
                        {})
      end
      file_name = @params["file_name"].to_s.parameterize + Time.now.to_i.to_s
      r = Aws::S3Manager.new.get_signed_post_url(GlobalConstant::Aws.image_upload_path + file_name,
                                                 @params["file_type"])
      success_with_data({url: r.url, fields: r.fields})
    end

    private

    def validate
      GlobalConstant::OstWeb.supported_image_type.include?(@params["file_type"])
    end

    def get_s3_path

    end
  end
end