lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'refile-filesystem-hashed'
  spec.version       = '1.0.2'
  spec.authors       = ['Tim Bleck']
  spec.email         = ['tim.bleck@webedia-group.com']
  spec.summary       = %q{Refile backend that's based on `Refile::Backend::FileSystem` and stores files in sub-directories based on the given file id instead of storing all files on one directory.}
  spec.homepage      = 'https://github.com/francois2metz/refile-filesystem-hashed'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'refile', '~> 0.5'
end
