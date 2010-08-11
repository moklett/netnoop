# NetNoop

Collects and stores your outgoing HTTP requests in NetNoop.requests for later inspection, usually in your test assertions or matchers.

Can be used in conjunction with FakeWeb to disable outbound HTTP requests while also making the contents of those requests visible.


    url = URI.parse("http://www.example.com/")
    req = Net::HTTP::Post.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req, "Inspect this.")
    }

    NetNoop.requests
    # => [#<NetNoop::Request:0x10052ba60 @method=:post, @uri="http://www.example.com/", @body="Inspect this.">]

    NetNoop.requests.first
    # => #<NetNoop::Request:0x10052ba60 @method=:post, @uri="http://www.example.com/", @body="Inspect this.">
  
    NetNoop.request_map
    # => {"http://www.example.com/"=>[#<NetNoop::Request:0x10052ba60 @method=:post, @uri="http://www.example.com/", @body="Inspect this.">]}

    NetNoop.request_map["http://www.example.com/"].first
    # => #<NetNoop::Request:0x10052ba60 @method=:post, @uri="http://www.example.com/", @body="Inspect this.">


Currently requires [FakeWeb](http://github.com/chrisk/fakeweb/), although this dependency can likely be later removed.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Michael Klett. See LICENSE for details.
