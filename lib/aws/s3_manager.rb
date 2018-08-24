module Aws

  class S3Manager

    def initialize

    end

    def get_signed_post_url(s3_name, content_type)
      post_policy = {
          key: s3_name,
          content_type: content_type,
          signature_expiration: Time.now + 1800,
          acl: 'public-read',
          content_length_range: (1024 * 1)..(1024 * 1024 * 5) # allow max 5 MB and min 50 kb
      }

      post = Aws::S3::PresignedPost.new(
          credentials_obj,
          region,
          bucket,
          post_policy
      )
    end

    # private

    def credentials_obj
      @credentials_obj ||= Aws::Credentials.new(
          access_key,
          secret_key
      )
    end

    # Access key
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil
    #
    # @return [String] returns access key for AWS
    #
    def access_key
      GlobalConstant::Aws.access_key
    end

    # Secret key
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil
    #
    # @return [String] returns secret key for AWS
    #
    def secret_key
      GlobalConstant::Aws.secret_key
    end

    # Region
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil
    #
    # @return [String] returns region
    #
    def region
      GlobalConstant::Aws.region
    end

    def bucket
      GlobalConstant::Aws.bucket
    end

  end

end