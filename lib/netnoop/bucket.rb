require 'singleton'

module NetNoop
  class Bucket
    include Singleton
    
    attr_accessor :request_map
    attr_accessor :requests
    
    def initialize
      empty_bucket
    end
    
    def add_request(uri, method, body = nil)
      req = NetNoop::Request.new(uri, method, body)
      self.request_map[uri] = self.request_map[uri] + [req]
      self.requests << req
    end
    
    def empty_bucket
      self.request_map = Hash.new([])
      self.requests = []
    end
  end
end
      