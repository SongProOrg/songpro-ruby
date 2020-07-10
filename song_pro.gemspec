# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'song_pro/version'

Gem::Specification.new do |spec|
  spec.name          = 'song_pro'
  spec.version       = SongPro::VERSION
  spec.authors       = ['Brian Kelly']
  spec.email         = ['polymonic@gmail.com']

  spec.summary       = 'Converts SongPro files to HTML'
  spec.description   = 'Provides classes for creating, parsing and rendering SongPro files'
  spec.homepage      = 'https://songpro.org'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'markaby'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
