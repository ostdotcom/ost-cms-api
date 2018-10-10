module GlobalConstant
  module Models
    class EntityDataVersion

      class << self

        def draft
          "draft"
        end

        def active
          "active"
        end

        def deleted
          "deleted"
        end
      end
    end
  end
end