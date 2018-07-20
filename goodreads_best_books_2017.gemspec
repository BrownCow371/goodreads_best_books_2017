
require_relative "./lib/goodreads_best_books_2017/version"

Gem::Specification.new do |spec|
  spec.name          = "goodreads_best_books_2017"
  spec.version       = GoodreadsBestBooks2017::VERSION
  spec.authors       = ["'Jamie Brown'"]
  spec.email         = ["'jmbrowncow@gmail.com'"]

  spec.summary       = "Best books by category"
  spec.description   = "Provides details on the best books in 2017 by category"
  spec.homepage      = "https://github.com/BrownCow371/goodreads_best_books_2017"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end
  #
  # # Specify which files should be added to the gem when it is released.
  # # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  # spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
end
