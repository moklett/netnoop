module NetNoop
  class Request
    attr_reader :uri
    attr_reader :method
    attr_reader :body
    
    def initialize(uri, method, body)
      @uri = uri
      @method = method
      @body = body
    end
  end
end