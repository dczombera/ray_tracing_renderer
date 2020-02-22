require_relative 'lib/ray_tracer/version'

Gem::Specification.new do |spec|
  spec.name          = "ray_tracer"
  spec.version       = RayTracer::VERSION
  spec.authors       = ["Dennis Czombera"]
  spec.email         = ["coding@dczomb.com"]

  spec.summary       = %q{A ray tracing renderer}
  spec.description   = %q{A ray tracing renderer}
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
