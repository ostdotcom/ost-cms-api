# frozen_string_literal: true
module GlobalConstant

  class AppConfig

    class << self

      def fetch_config
        @fetch_config ||= begin
          template = ERB.new File.new("#{Rails.root}/config/app_config.yml").read
          YAML.load(template.result(binding)) || {}
        end
      end

    end

  end

end
