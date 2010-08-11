require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NetNoop" do
  before(:each) do
    NetNoop.empty_bucket
  end
  
  context "upon a GET request" do
    attr_reader :the_stored_request
    
    before(:each) do
      perform_net_http_get(example_uri)
      @the_stored_request = NetNoop.requests.last
    end
    
    it "stores 1 request in the +NetNoop.requests+ array" do
      NetNoop.requests.size.should == 1
    end
    
    it "is stores 1 request in the +NetNoop.request_map+ hash at the correct key" do
      NetNoop.request_map[example_uri].size.should == 1
    end
    
    describe "the stored request" do
      it "holds the URI" do
        the_stored_request.uri.should == example_uri
      end
      
      it "holds the method" do
        the_stored_request.method.should == :get
      end
      
      it "has a nil body" do
        the_stored_request.body.should be_nil
      end
    end
    
    describe "the stored response" do
      attr_reader :uri, :response_body, :response_status, :response_content_type, :the_stored_response
      
      before(:each) do
        @uri = "http://www.example.com/storeresponse"
        response_hash = {
          :body => @response_body = "I am the response",
          :status => @response_status = '200',
        }.merge({:content_type => @response_content_type = "text/plain"})
        
        FakeWeb.register_uri(:any, uri, response_hash)
        perform_net_http_get(uri)
        @the_stored_response = NetNoop.requests.last.response
      end
      
      it "is present" do
        the_stored_response.should_not be_nil
      end
      
      it "holds the response status" do
        the_stored_response.status.should == response_status
      end
      
      it "holds the response body" do
        the_stored_response.body.should == response_body
      end
      
      it "holds the response headers" do
        the_stored_response.headers.should be_a(Hash)
      end
      
      it "parses the content-type" do
        the_stored_response.content_type.should == response_content_type
      end
    end
  end
  
  context "upon a POST request" do
    it "stores the request in the +requests+ array and the body is accessible" do
      body = "I am the request body"
      perform_net_http_post(example_uri, body)
      NetNoop.requests.first.body.should == body
    end
  end
  
  it "does not interfere with the original request" do
    lambda {
      perform_net_http_get("http://www.example.com/foobar.html")
    }.should raise_error(FakeWeb::NetConnectNotAllowedError)
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
