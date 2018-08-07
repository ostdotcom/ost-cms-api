# frozen_string_literal: true
module GlobalConstant

  class Email

    class << self

      def default_from
        'kyc.notifier@ost.com'
      end

      def default_to
        ['mayur@ost.com', 'akshay@ost.com']
      end

      def default_pm_to
        ['mayur@ost.com']
      end

      def st_balance_report_email_to
        ['mayur@ost.com']
      end

      def contact_us_admin_email
        Rails.env.production? ? 'mayur@ost.com' : 'mayur@ost.com'
      end

      def default_directors_to
        ['mayur@ost.com']
      end

      def default_eth_devs_to
        ['mayur@ost.com']
      end

      def subject_prefix
        "STA #{Rails.env} : "
      end

    end

  end

end
