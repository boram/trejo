# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trejo/version"

Gem::Specification.new do |s|
  s.name        = "trejo"
  s.version     = Trejo::VERSION
  s.authors     = ["Boram Yoon"]
  s.email       = ["boram@me.com"]
  s.homepage    = "http://github.com/boram/trejo"
  s.summary     = %q{Navigation link helper}
  s.description = %q{Navigation links with active states based on current path}

  s.rubyforge_project = "trejo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency 'actionpack', ['>= 3.0.0']
  s.add_development_dependency "rspec"
end
