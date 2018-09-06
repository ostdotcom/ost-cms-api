module GlobalConstant

  class Aws

    class << self

      def access_key
        GlobalConstant::Base.aws_credentials[:access_key]
      end

      def secret_key
        GlobalConstant::Base.aws_credentials[:secret_key]
      end

      def region
        GlobalConstant::Base.aws_credentials[:region]
      end

      def bucket
        GlobalConstant::Base.aws_credentials[:bucket]
      end

      def image_upload_path
        (Rails.env.production? ? "" : "#{Rails.env.to_s}_") + "ost/images/"
      end

      def json_file_upload_path
        (Rails.env.production? ? "" : "#{Rails.env.to_s}_") + "ost/json_files/"
      end

    end

  end

end