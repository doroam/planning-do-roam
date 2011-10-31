# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{httpclient}
  s.version = "2.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hiroshi Nakamura"]
  s.date = %q{2011-10-28}
  s.email = %q{nahi@ruby-lang.org}
  s.files = ["lib/httpclient/auth.rb", "lib/httpclient/ssl_config.rb", "lib/httpclient/http.rb", "lib/httpclient/cacert_sha1.p7s", "lib/httpclient/timeout.rb", "lib/httpclient/version.rb", "lib/httpclient/connection.rb", "lib/httpclient/session.rb", "lib/httpclient/cacert.p7s", "lib/httpclient/cookie.rb", "lib/httpclient/util.rb", "lib/oauthclient.rb", "lib/httpclient.rb", "lib/http-access2.rb", "lib/http-access2/http.rb", "lib/http-access2/cookie.rb", "lib/hexdump.rb", "sample/auth.rb", "sample/dav.rb", "sample/stream.rb", "sample/async.rb", "sample/wcat.rb", "sample/ssl/1000cert.pem", "sample/ssl/1000key.pem", "sample/ssl/ssl_client.rb", "sample/ssl/0key.pem", "sample/ssl/htdocs/index.html", "sample/ssl/0cert.pem", "sample/ssl/webrick_httpsd.rb", "sample/thread.rb", "sample/oauth_friendfeed.rb", "sample/oauth_twitter.rb", "sample/cookie.rb", "sample/howto.rb", "sample/oauth_buzz.rb", "test/client.cert", "test/test_http-access2.rb", "test/server.cert", "test/htdigest", "test/test_ssl.rb", "test/test_cookie.rb", "test/runner.rb", "test/htpasswd", "test/test_auth.rb", "test/client.key", "test/helper.rb", "test/ca.cert", "test/sslsvr.rb", "test/subca.cert", "test/server.key", "test/test_httpclient.rb"]
  s.homepage = %q{http://github.com/nahi/httpclient}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{gives something like the functionality of libwww-perl (LWP) in Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
