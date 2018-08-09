module Util
  class CommonValidator

    REGEX_EMAIL = /\A[A-Z0-9]+[A-Z0-9_%+-]*(\.[A-Z0-9_%+-]{1,})*@(?:[A-Z0-9](?:[A-Z0-9-]*[A-Z0-9])?\.)+[A-Z]{2,24}\Z/mi


    def self.is_numeric?(object)
      true if Float(object) rescue false
    end


    def self.is_boolean_string?(object)
      %w(0 1).include?(object.to_s)
    end


    def self.is_boolean?(object)
      [
          true,
          false
      ].include?(object)
    end


    def self.are_numeric?(objects)
      return false unless objects.is_a?(Array)
      are_numeric = true
      objects.each do |object|
        unless self.is_numeric?(object)
          are_numeric = false
          break
        end
      end
      return are_numeric
    end


    def self.is_a_hash?(obj)
      obj.is_a?(Hash) || obj.is_a?(ActionController::Parameters)
      true
    end


    def self.is_valid_email?(email)
      email =~ REGEX_EMAIL
    end


    def self.is_alphanumeric?(name)
      name =~ /\A[A-Z0-9]+\Z/i
    end




  end

end
