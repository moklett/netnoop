$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'netnoop'
require 'spec'
require 'spec/autorun'

def example_uri
  "http://www.example.com/"
end

# FakeWeb setup
FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, example_uri, :body => "Hello World")
  
Spec::Runner.configure do |config|
end

