# frozen_string_literal: true
module GlobalConstant

  class OstWeb < GlobalConstant::Base

    class << self

      def url
        @url ||= ost_web['url']
      end

      def sha256_salt
        @sha256_salt ||= ost_web['sha256_salt']
      end

      def supported_image_type
        @supported_image_types ||=  ost_web['supported_image_types'].split(' ')
      end

      private

      def ost_web
        @ost_web ||= GlobalConstant::Base.ost_web
      end

    end

  end

end
