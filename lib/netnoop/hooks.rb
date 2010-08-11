module Net
  class HTTP
    def request_with_netnoop(request, body = nil, &block)
      uri, method = netnoop_parse_request_details(request)
      
      NetNoop::Bucket.instance.add_request(uri, method, body)
      request_without_netnoop(request, body, &block)
    end
    alias_method :request_without_netnoop, :request
    alias_method :request, :request_with_netnoop
    
    private
    
    # Borrowed from FakeWeb code
    def netnoop_parse_request_details(request)
      protocol = use_ssl? ? "https" : "http"

      path = request.path
      path = URI.parse(request.path).request_uri if request.path =~ /^http/

      if request["authorization"] =~ /^Basic /
        userinfo = FakeWeb::Utility.decode_userinfo_from_header(request["authorization"])
        userinfo = FakeWeb::Utility.encode_unsafe_chars_in_userinfo(userinfo) + "@"
      else
        userinfo = ""
      end
      
      # TODO: optionally store the port
      # uri = "#{protocol}://#{userinfo}#{self.address}:#{self.port}#{path}"
      uri = "#{protocol}://#{userinfo}#{self.address}#{path}"
      method = request.method.downcase.to_sym
      
      return uri, method
    end
  end
end