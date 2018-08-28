module Aws

  class S3Manager

    def initialize

    end

    def get_signed_post_url(s3_path, content_type)
      post_policy = {
          key: s3_path,
          content_type: content_type,
          signature_expiration: Time.now + 1800,
          acl: 'public-read',
          content_length_range: (1024 * 1)..(1024 * 1024 * 5) # max and min filesize in KB
      }

      post = Aws::S3::PresignedPost.new(
          credentials_obj,
          region,
          bucket,
          post_policy
      )
    end

    def   store(s3_path, body, bucket, options = {})
    params = {
        key: s3_path,
        body: body,
        bucket: bucket
    }
    options.merge!({
                    acl: "public"
                   })

    client.put_object(params.merge(options))

    end

    def client
      @client ||= Aws::S3::Client.new(
          access_key_id: access_key,
          secret_access_key: secret_key,
          region: region
      )
    end

    private

    def credentials_obj
      @credentials_obj ||= Aws::Credentials.new(
          access_key,
          secret_key
      )
    end

    def access_key
      GlobalConstant::Aws.access_key
    end

    def secret_key
      GlobalConstant::Aws.secret_key
    end

    def region
      GlobalConstant::Aws.region
    end

    def bucket
      GlobalConstant::Aws.bucket
    end

  end

end