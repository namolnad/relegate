# frozen_string_literal: true

require_relative "lib/relegate/version"

Gem::Specification.new do |spec|
  spec.name = "relegate"
  spec.version = Relegate::VERSION
  spec.summary = "A simple ActiveRecord archiving gem"
  spec.homepage = "https://github.com/namolnad/relegate"
  spec.license = "MIT"

  spec.authors = ["Dan Loman"]
  spec.email = ["daniel.h.loman@gmail.com"]

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.1.0"

  spec.add_dependency "activesupport", ">= 7.1"
end
