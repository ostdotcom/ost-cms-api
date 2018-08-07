module DbService
  class Base

    def initialize(params)
      params.delete("controller")
      params.delete("action")
      @params = params
    end

    def validate
      puts "I am in validate"
    end


  end
end