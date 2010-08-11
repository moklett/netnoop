module Net
  class HTTP
    def request_with_netnoop(request, body = nil, &block)
      NetNoop::Bucket.instance.add_request(request)
      request_without_netnoop(request, body, &block)
    end
    alias_method :request_without_netnoop, :request
    alias_method :request, :request_with_netnoop
  end
end