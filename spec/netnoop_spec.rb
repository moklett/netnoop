require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NetNoop" do
  before(:each) do
    NetNoop.empty_bucket
  end
  
  context "upon a GET request" do
    it "stores the request in the +requests+ array" do
      perform_net_http_get(example_uri)
      
      req = NetNoop.requests.first
      req.uri.should == example_uri
      req.method.should == :get
    end

    it "stores the request in the +request_map+ hash" do
      perform_net_http_get(example_uri)
      
      req = NetNoop.request_map[example_uri].first
      req.uri.should == example_uri
      req.method.should == :get
    end
  end
  
  context "upon a POST request" do
    it "stores the request in the +requests+ array and the body is accessible" do
      body = "I am the request body"
      perform_net_http_post(example_uri, body)
      NetNoop.requests.first.body.should == body
    end
  end
  
  
  def perform_net_http_get(uri)
    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
  end

  def perform_net_http_post(uri, body)
    url = URI.parse(uri)
    req = Net::HTTP::Post.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req, body)
    }
  end
end
