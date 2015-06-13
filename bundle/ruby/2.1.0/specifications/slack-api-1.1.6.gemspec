# -*- encoding: utf-8 -*-
# stub: slack-api 1.1.6 ruby lib

Gem::Specification.new do |s|
  s.name = "slack-api"
  s.version = "1.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["aki017"]
  s.date = "2015-05-27"
  s.description = "A Ruby wrapper for the Slack API"
  s.email = ["aki@aki017.info"]
  s.homepage = "https://github.com/aki017/slack-ruby-gem"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.2"
  s.summary = "A Ruby wrapper for the Slack API"

  s.installed_by_version = "2.4.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<erubis>, ["~> 2.7.0"])
      s.add_development_dependency(%q<json-schema>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_runtime_dependency(%q<faraday>, ["< 0.10", ">= 0.7"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.8"])
      s.add_runtime_dependency(%q<multi_json>, [">= 1.0.3", "~> 1.0"])
      s.add_runtime_dependency(%q<faye-websocket>, ["~> 0.9.2"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<erubis>, ["~> 2.7.0"])
      s.add_dependency(%q<json-schema>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<faraday>, ["< 0.10", ">= 0.7"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.8"])
      s.add_dependency(%q<multi_json>, [">= 1.0.3", "~> 1.0"])
      s.add_dependency(%q<faye-websocket>, ["~> 0.9.2"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<erubis>, ["~> 2.7.0"])
    s.add_dependency(%q<json-schema>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<faraday>, ["< 0.10", ">= 0.7"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.8"])
    s.add_dependency(%q<multi_json>, [">= 1.0.3", "~> 1.0"])
    s.add_dependency(%q<faye-websocket>, ["~> 0.9.2"])
  end
end
