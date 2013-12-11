# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'viki_disqus/version'

Gem::Specification.new do |spec|
  spec.name          = "viki_disqus"
  spec.version       = VikiDisqus::VERSION
  spec.authors       = ["Tang Chin Yong", "Pang Yan Han"]
  spec.email         = ["engineering@viki.com"]
  spec.description   = %q{Viki Disqus Gem - for Single Sign-On (SSO)}
  spec.summary       = %q{Viki Disqus Gem - for Single Sign-On (SSO)}
  spec.homepage      = "http://engineering.viki.com"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
end
