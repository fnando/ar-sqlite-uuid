# frozen_string_literal: true

require "./lib/ar/uuid/version"

repo = "https://github.com/fnando/ar-sqlite-uuid"
version = AR::UUID::VERSION

Gem::Specification.new do |spec|
  spec.name          = "ar-sqlite-uuid"
  spec.version       = version
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["me@fnando.com"]
  spec.summary       = "Override migration methods to support UUID/ULID " \
                       "columns without having to be explicit about it."
  spec.description                 = spec.summary
  spec.homepage                    = repo
  spec.metadata["bug_tracker_uri"] = "#{repo}/issues"
  spec.metadata["changelog_uri"]   = "#{repo}/tree/main/CHANGELOG.md"
  spec.metadata["source_code_uri"] = "#{repo}/tree/v#{version}"
  spec.metadata["funding_uri"]     = "https://github.com/sponsors/fnando"
  spec.license                     = "MIT"
  spec.required_ruby_version       = Gem::Requirement.new(">= 3.2.0")
  spec.metadata["rubygems_mfa_required"] = "true"
  p spec.metadata

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 8.0.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-fnando"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sqlite3"
end
