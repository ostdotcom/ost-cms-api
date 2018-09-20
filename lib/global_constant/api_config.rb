# frozen_string_literal: true
module GlobalConstant

  class ApiConfig

    class << self

      def fetch_config()
        @fetch_config ||= begin
          template = ERB.new File.new("#{Rails.root}/config/api_config.yml").read
          YAML.load(template.result(binding)) || {}
        end
      end

      def fetch_entity_config(entity)
          template = ERB.new File.new("#{Rails.root}/config/api_config.yml").read
          config = YAML.load(template.result(binding))
          entity_config = config["meta"][entity.to_sym]
          entity_info = Entity.find_by_name(entity)
          {"fields" => entity_config, "meta" =>  {"entity_type" => entity_info.configuration, "entity_name" => entity_info.name }}
      end

    end

  end

end
