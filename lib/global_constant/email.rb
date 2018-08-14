# frozen_string_literal: true
module GlobalConstant

  class Email

    class << self

      def default_from
        'ostcms.notifier@ost.com'
      end

      def default_to
        ['mayur@ost.com', 'akshay@ost.com', 'preshita@ost.com', 'backend.team@ost.com']
      end

      def subject_prefix
        "OCA #{Rails.env} : "
      end

    end

  end

end
