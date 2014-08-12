# coding: utf-8
#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$:.push File.expand_path("../lib", __FILE__)
require 'nice/diff/version'

Gem::Specification.new do |spec|
  spec.name          = "nice-diff"
  spec.version       = Nice::VERSION
  spec.authors       = ["Ravi Kandpal"]
  spec.email         = ["ravi.kandpal87@gmail.com"]
  spec.summary       = %q{Nice diff gives nice readable diff view in tabular format.}
  spec.description   = %q{Nice diff generates the tabular readable diff of two JSON or XML files. A file object reference to corresponding JSON or XML files needs to be passed along with the format type being expressed.}
  spec.homepage      = "https://github.com/ravik87/nice-diff"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "active_support", "~> 3.0.0"
end
