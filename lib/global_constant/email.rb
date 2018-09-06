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

      def whitelisted_users
        @whitelisted_users ||= GlobalConstant::Base.cms_api[:whitelisted_users].split(' ')
      end

      def is_whitelisted_email?(user_email)
        if Rails.env.production?
          whitelisted_users
          @whitelisted_users.include? user_email
        else
          user_email.to_s.end_with?("@ost.com")
        end
      end

    end

  end

end
