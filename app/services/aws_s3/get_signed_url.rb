module AwsS3

  class GetSignedUrl

    include ::Util::ResultHelper

    def initialize(params)
      @params = params
    end

    def perform
      file_name = @params["images"]["image_name"] + Time.now.to_i.to_s
      r = Aws::S3Manager.new.get_signed_post_url(GlobalConstant::Aws.directory_location + file_name,
                                                 @params["images"]["news_list_image"])
      success_with_data(
                          {
                              "news_list_image" => {
                                  url: r.url,
                                  fields: r.fields
                              }
                          }
                        )
    end



  end
end