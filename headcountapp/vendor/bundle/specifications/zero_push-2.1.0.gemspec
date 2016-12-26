# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "zero_push"
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Natchev", "Adam Duke"]
  s.date = "2014-01-03"
  s.description = "ZeroPush is a simple service for sending iOS push notifications. (http://zeropush.com)"
  s.email = ["stefan.natchev@gmail.com", "adam.v.duke@gmail.com"]
  s.homepage = "https://zeropush.com"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubygems_version = "2.0.14"
  s.summary = "A gem for interacting with the ZeroPush API. (http://zeropush.com)"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.8.5"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
      s.add_development_dependency(%q<actionpack>, ["~> 3.2.11"])
      s.add_development_dependency(%q<activesupport>, ["~> 3.2.11"])
      s.add_development_dependency(%q<minitest>, ["~> 4.7.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.13.3"])
      s.add_development_dependency(%q<rake>, ["~> 10.0.3"])
      s.add_development_dependency(%q<railties>, ["~> 3.2.11"])
      s.add_development_dependency(%q<vcr>, ["~> 2.4.0"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.8.5"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
      s.add_dependency(%q<actionpack>, ["~> 3.2.11"])
      s.add_dependency(%q<activesupport>, ["~> 3.2.11"])
      s.add_dependency(%q<minitest>, ["~> 4.7.0"])
      s.add_dependency(%q<mocha>, ["~> 0.13.3"])
      s.add_dependency(%q<rake>, ["~> 10.0.3"])
      s.add_dependency(%q<railties>, ["~> 3.2.11"])
      s.add_dependency(%q<vcr>, ["~> 2.4.0"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.8.5"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
    s.add_dependency(%q<actionpack>, ["~> 3.2.11"])
    s.add_dependency(%q<activesupport>, ["~> 3.2.11"])
    s.add_dependency(%q<minitest>, ["~> 4.7.0"])
    s.add_dependency(%q<mocha>, ["~> 0.13.3"])
    s.add_dependency(%q<rake>, ["~> 10.0.3"])
    s.add_dependency(%q<railties>, ["~> 3.2.11"])
    s.add_dependency(%q<vcr>, ["~> 2.4.0"])
  end
end
