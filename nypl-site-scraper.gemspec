# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nypl_site_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "nypl-site-scraper"
  spec.version       = NyplSiteScraper::VERSION
  spec.authors       = ["nodanaonlyzuul"]

  spec.summary       = %q{A mechanize-driven client to scrape info about your account from NYPL}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "http://github.com/nodanaonlyzuul/nypl-site-scraper"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "rubygems.org"
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

  spec.add_dependency 'mechanize', '~> 2.7', '>= 2.7.3'
  spec.add_development_dependency "pry", '~> 0.11.3'
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
