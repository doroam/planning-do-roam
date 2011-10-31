# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{httpi}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Harrington", "Martin Tepper"]
  s.date = %q{2011-06-29}
  s.description = %q{HTTPI provides a common interface for Ruby HTTP libraries.}
  s.email = %q{me@rubiii.com}
  s.files = [".autotest", ".gitignore", ".rspec", ".travis.yml", "CHANGELOG.md", "Gemfile", "LICENSE", "README.md", "Rakefile", "autotest/discover.rb", "httpi.gemspec", "lib/httpi.rb", "lib/httpi/adapter.rb", "lib/httpi/adapter/curb.rb", "lib/httpi/adapter/httpclient.rb", "lib/httpi/adapter/net_http.rb", "lib/httpi/auth/config.rb", "lib/httpi/auth/ssl.rb", "lib/httpi/dime.rb", "lib/httpi/request.rb", "lib/httpi/response.rb", "lib/httpi/version.rb", "spec/fixtures/attachment.gif", "spec/fixtures/client_cert.pem", "spec/fixtures/client_key.pem", "spec/fixtures/xml.gz", "spec/fixtures/xml.xml", "spec/fixtures/xml_dime.dime", "spec/fixtures/xml_dime.xml", "spec/httpi/adapter/curb_spec.rb", "spec/httpi/adapter/httpclient_spec.rb", "spec/httpi/adapter/net_http_spec.rb", "spec/httpi/adapter_spec.rb", "spec/httpi/auth/config_spec.rb", "spec/httpi/auth/ssl_spec.rb", "spec/httpi/httpi_spec.rb", "spec/httpi/request_spec.rb", "spec/httpi/response_spec.rb", "spec/integration/request_spec.rb", "spec/integration/server.rb", "spec/spec_helper.rb", "spec/support/fixture.rb", "spec/support/matchers.rb"]
  s.homepage = %q{http://github.com/rubiii/httpi}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{httpi}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Interface for Ruby HTTP libraries}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.2"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.9"])
      s.add_development_dependency(%q<webmock>, ["~> 1.4.0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.2"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<mocha>, ["~> 0.9.9"])
      s.add_dependency(%q<webmock>, ["~> 1.4.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.2"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<mocha>, ["~> 0.9.9"])
    s.add_dependency(%q<webmock>, ["~> 1.4.0"])
  end
end
