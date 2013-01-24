# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'has_meta/version'

Gem::Specification.new do |gem|
  gem.name          = "has_meta"
  gem.version       = HasMeta::VERSION
  gem.authors       = ["Philip Hallstrom"]
  gem.email         = ["philip@pjkh.com"]
  gem.description   = %q{Adds convenience methods to extract "meta" (as in http meta) strings from models.}
  gem.summary       = %q{Adds convenience methods to extract "meta" (as in http meta) strings from models by using existing fields for source data. Strings are stripped of html tags and truncated to length (default 255).}
  gem.homepage      = "https://github.com/phallstrom/has_meta"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
