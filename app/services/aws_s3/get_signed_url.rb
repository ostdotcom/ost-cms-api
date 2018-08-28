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
      file_name = @params["file_name"] + Time.now.to_i.to_s
      r = Aws::S3Manager.new.get_signed_post_url(GlobalConstant::Aws.image_upload_path + file_name,
                                                 @params["file_type"])
      success_with_data({url: r.url, fields: r.fields})
    end

    private

    def validate
      @supported_content_type = GlobalConstant::Base.supported_image_type
      @supported_content_type.include?  @params["file_type"]
    end
  end
end