# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3_streamer/version'

Gem::Specification.new do |spec|
  spec.name          = 's3_streamer'
  spec.version       = S3Streamer::VERSION
  spec.authors       = ['thilonel']
  spec.email         = ['naitodai@gmail.com']

  spec.summary       = %q{Stream a file from a remote url using the Ruby AWS SDK to an Amazon S3 bucket.}
  spec.homepage      = 'https://github.com/thilonel/s3_streamer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'dotenv'

  spec.add_runtime_dependency 'aws-sdk'
end
