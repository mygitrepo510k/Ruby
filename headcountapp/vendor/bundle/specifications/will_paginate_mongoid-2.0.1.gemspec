# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "will_paginate_mongoid"
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lucas Souza"]
  s.date = "2013-09-12"
  s.description = ""
  s.email = ["lucasas@gmail.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "will_paginate_mongoid"
  s.rubygems_version = "2.0.14"
  s.summary = "An extension that becomes possible use paginate method with Mongoid"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, [">= 0"])
      s.add_runtime_dependency(%q<will_paginate>, ["~> 3.0"])
    else
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<will_paginate>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<will_paginate>, ["~> 3.0"])
  end
end
