# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "carrierwave-mongoid"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonas Nicklas", "Trevor Turk"]
  s.date = "2011-08-11"
  s.description = "Mongoid support for CarrierWave"
  s.email = ["jonas.nicklas@gmail.com"]
  s.homepage = "https://github.com/jnicklas/carrierwave-mongoid"
  s.require_paths = ["lib"]
  s.rubyforge_project = "carrierwave-mongoid"
  s.rubygems_version = "2.0.14"
  s.summary = "Mongoid support for CarrierWave"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<carrierwave>, [">= 0"])
      s.add_runtime_dependency(%q<mongoid>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<bson_ext>, ["> 1.3.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<carrierwave>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<bson_ext>, ["> 1.3.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<carrierwave>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<bson_ext>, ["> 1.3.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
