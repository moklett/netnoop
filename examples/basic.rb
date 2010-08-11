$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'netnoop'

url = URI.parse("http://www.example.com/")
req = Net::HTTP::Post.new(url.path)
res = Net::HTTP.start(url.host, url.port) {|http|
  http.request(req, "Inspect this.")
}

p NetNoop.requests

p NetNoop.requests.first

p NetNoop.request_map

p NetNoop.request_map["http://www.example.com/"].first
