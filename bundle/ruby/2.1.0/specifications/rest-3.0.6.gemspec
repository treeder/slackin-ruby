# -*- encoding: utf-8 -*-
# stub: rest 3.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "rest"
  s.version = "3.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Travis Reeder"]
  s.date = "2015-02-26"
  s.description = "Rest client wrapper that chooses best installed client."
  s.email = ["treeder@gmail.com"]
  s.homepage = "https://github.com/iron-io/rest"
  s.required_ruby_version = Gem::Requirement.new(">= 1.8")
  s.rubygems_version = "2.4.2"
  s.summary = "Rest client wrapper that chooses best installed client."

  s.installed_by_version = "2.4.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-http-persistent>, [">= 2.9.1"])
      s.add_runtime_dependency(%q<netrc>, [">= 0"])
      s.add_development_dependency(%q<typhoeus>, [">= 0.5.4"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<uber_config>, [">= 0"])
      s.add_development_dependency(%q<quicky>, [">= 0.4.0"])
      s.add_development_dependency(%q<excon>, [">= 0"])
    else
      s.add_dependency(%q<net-http-persistent>, [">= 2.9.1"])
      s.add_dependency(%q<netrc>, [">= 0"])
      s.add_dependency(%q<typhoeus>, [">= 0.5.4"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<uber_config>, [">= 0"])
      s.add_dependency(%q<quicky>, [">= 0.4.0"])
      s.add_dependency(%q<excon>, [">= 0"])
    end
  else
    s.add_dependency(%q<net-http-persistent>, [">= 2.9.1"])
    s.add_dependency(%q<netrc>, [">= 0"])
    s.add_dependency(%q<typhoeus>, [">= 0.5.4"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<uber_config>, [">= 0"])
    s.add_dependency(%q<quicky>, [">= 0.4.0"])
    s.add_dependency(%q<excon>, [">= 0"])
  end
end
