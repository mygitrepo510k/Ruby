# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "hub"
  s.version = "1.11.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Wanstrath", "Mislav Marohni\u{107}"]
  s.date = "2014-02-02"
  s.description = "  `hub` is a command line utility which adds GitHub knowledge to `git`.\n\n  It can used on its own or as a `git` wrapper.\n\n  Normal:\n\n      $ hub clone rtomayko/tilt\n\n      Expands to:\n      $ git clone git://github.com/rtomayko/tilt.git\n\n  Wrapping `git`:\n\n      $ git clone rack/rack\n\n      Expands to:\n      $ git clone git://github.com/rack/rack.git\n"
  s.email = "mislav.marohnic@gmail.com"
  s.executables = ["hub"]
  s.files = ["bin/hub"]
  s.homepage = "http://hub.github.com/"
  s.licenses = ["MIT"]
  s.post_install_message = "\n------------------------------------------------------------\n\n                  You there! Wait, I say!\n                  =======================\n\n       If you are a heavy user of `git` on the command\n       line  you  may  want  to  install `hub` the old\n       fashioned way.  Faster  startup  time,  you see.\n\n       Check  out  the  installation  instructions  at\n       https://github.com/github/hub#readme  under the\n       \"Standalone\" section.\n\n       Cheers,\n       defunkt\n\n------------------------------------------------------------\n\n"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Command-line wrapper for git and GitHub"
end
