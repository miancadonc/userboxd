lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "/Users/nat/Gems/userboxd/lib/version.rb"

Gem::Specification.new do |spec|
  spec.name          = "userboxd"
  spec.version       = Userboxd::VERSION
  spec.authors       = ["Nat McConnaughay"]
  spec.email         = ["natmcconnaughay@gmail.com"]

  spec.summary       = %q{Allows comparison of the preferences of two letterboxd users.]}
  spec.description   = %q{This gem scrapes the site letterboxd (letterboxd provides an api on request, and I will be requesting access.). It creates users to display, and logs their rated films on the site. It takes note of the genres and can display decriptive information on the users and their rated films. It can also directly compare two letterboxd users in a small variety of ways, including total films rated.}
  spec.homepage      = "https://github.com/miancadonc/userboxd"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://github.com/miancadonc/userboxd'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/miancadonc/userboxd"
  spec.metadata["changelog_uri"] = "https://github.com/miancadonc/userboxd"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
  #spec.add_development_dependency "open-uri"
  
end
