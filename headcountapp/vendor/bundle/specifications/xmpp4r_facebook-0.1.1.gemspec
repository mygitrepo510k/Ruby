# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "xmpp4r_facebook"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kissrobber"]
  s.date = "2012-02-29"
  s.description = "Expansion XMPP4R to authenticate with Facebook Connect in Ruby"
  s.email = "kissrobber@gmail.com"
  s.homepage = "https://github.com/kissrobber"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Expansion XMPP4R to authenticate with Facebook Connect in Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xmpp4r>, [">= 0"])
    else
      s.add_dependency(%q<xmpp4r>, [">= 0"])
    end
  else
    s.add_dependency(%q<xmpp4r>, [">= 0"])
  end
end
