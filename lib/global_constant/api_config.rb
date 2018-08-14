# frozen_string_literal: true
module GlobalConstant

  class ApiConfig

    class << self

      def fetch_config
        @fetch_config ||= begin
          template = ERB.new File.new("#{Rails.root}/config/api_config.yml").read
          YAML.load(template.result(binding)) || {}
        end
      end

    end

  end

end
