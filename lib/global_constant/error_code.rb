# frozen_string_literal: true
module GlobalConstant

  class ErrorCode

    def self.ok
      200
    end

    def self.bad_request
      400
    end

    def self.unauthorized_access
      401
    end

    def self.forbidden
      403
    end

    def self.not_found
      404
    end

    def self.internal_server_error
      500
    end

    def self.permanent_redirect
      301
    end

    def self.temporary_redirect
      302
    end

    def self.allowed_http_codes
      [
          ok,
          unauthorized_access,
          not_found,
          forbidden,
          bad_request,
          internal_server_error
      ]
    end



  end

end
