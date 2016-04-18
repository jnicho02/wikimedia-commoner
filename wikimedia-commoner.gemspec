# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wikimedia/commoner/version'

Gem::Specification.new do |spec|
  spec.name          = "wikimedia-commoner"
  spec.version       = Wikimedia::Commoner::VERSION
  spec.authors       = ["Jez Nicholson"]
  spec.email         = ["jez.nicholson@gmail.com"]
  spec.summary       = %q{Quick and easy access to Wikimedia Commons image data}
  spec.description   = %q{The missing API for obtaining metadata about Wikimedia Commons images. e.g. who to acknowledge as the copyright owner}
  spec.homepage      = "http://github.com/jnicho02/wikimedia-commoner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
