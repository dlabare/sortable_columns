# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sortable_columns/version'

Gem::Specification.new do |spec|
  spec.name          = "sortable_columns"
  spec.version       = SortableColumns::VERSION
  spec.authors       = ["Daniel LaBare"]
  spec.email         = ["dlabare@gmail.com"]
  spec.description   = %q{TODO: Simple sortable columns for your Rails app}
  spec.summary       = %q{TODO: Sort a simple dataset by column headers}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
