
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "more_holiday/version"

Gem::Specification.new do |spec|
  spec.name          = "more_holiday"
  spec.version       = MoreHoliday::VERSION
  spec.authors       = ["Frederic Walch"]
  spec.email         = ["fredericwalch@me.com"]

  spec.summary       = %q{Get more out of your holidays! Use bridge days smartly.}
  spec.description   = %q{Get more out of your holidays! Use bridge days smartly.}
  spec.homepage      = "https://github.com/freder1c"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "icalendar", "~> 2.4"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.3"

  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-nav", "~> 0.2"

  spec.add_development_dependency "simplecov", "~> 0.16"
end
