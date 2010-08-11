module NetNoop
  class Request
    attr_reader :uri
    attr_reader :method
    attr_reader :body
    attr_reader :response
    
    def initialize(uri, method, body, http_response = nil)
      @uri = uri
      @method = method
      @body = body
      @response = Response.new(http_response)
    end
  end
end