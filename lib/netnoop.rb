begin
  require 'fakeweb'
rescue LoadError
  require 'rubygems'
  require 'fakeweb'
end

require 'uri'
require 'netnoop/hooks'
require 'netnoop/request'
require 'netnoop/bucket'

module NetNoop
  def self.requests
    Bucket.instance.requests
  end
  
  def self.request_map
    Bucket.instance.request_map
  end
  
  def self.empty_bucket
    Bucket.instance.empty_bucket
  end
end
  