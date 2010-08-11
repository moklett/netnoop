module NetNoop
  class Response
    attr_reader :status
    attr_reader :body
    attr_reader :headers
    
    def initialize(http_response)
      @status   = http_response.code
      @body     = http_response.body
      @headers  = http_response.header.to_hash
    end
    
    def content_type
      if ct = headers['content-type']
        return ct.first if ct.is_a?(Array)
        return ct
      end
    end
  end
end