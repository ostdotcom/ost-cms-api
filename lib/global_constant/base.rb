# frozen_string_literal: true
module GlobalConstant

  class Base

    class << self

      def root_url
        @root_url ||= fetch_config.fetch('root_url', '')
      end

      def cms_api
        @cms_api ||= fetch_config.fetch('cms_api', {}).with_indifferent_access
      end

      def oauth
        @oauth ||= fetch_config.fetch('oauth', {}).with_indifferent_access
      end

      def sha256_salt
        @oauth ||= fetch_config.fetch('sha256_salt', {}).with_indifferent_access
      end

      private

      def fetch_config
        @fetch_config ||= begin
          template = ERB.new File.new("#{Rails.root}/config/constants.yml").read
          YAML.load(template.result(binding)).fetch('constants', {}) || {}
        end
      end

    end

  end

end
