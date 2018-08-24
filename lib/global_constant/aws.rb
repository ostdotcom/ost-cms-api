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

      def directory_location
        GlobalConstant::Base.aws_credentials[:directory_location]
      end

    end

  end

end