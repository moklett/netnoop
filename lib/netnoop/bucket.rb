require 'singleton'

module NetNoop
  class Bucket
    include Singleton
    
    attr_accessor :request_map
    attr_accessor :requests
    
    def initialize
      empty_bucket
    end
    
    def add_request(req)
      self.request_map[req.uri] = self.request_map[req.uri] + [req]
      self.requests << req
    end
    
    def empty_bucket
      self.request_map = Hash.new([])
      self.requests = []
    end
  end
end
      