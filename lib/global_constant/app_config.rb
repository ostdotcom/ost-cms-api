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

      def new_entity_order_weight
        100000000000000000000000.0
      end

      def threshold_order_weight
        1000.0
      end

    end

  end

end
