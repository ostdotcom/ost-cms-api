module GlobalConstant

  class Cloudfront

    class << self

      def url
        GlobalConstant::Base.cloudfront[:url]
      end

    end

  end

end