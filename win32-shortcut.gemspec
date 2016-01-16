require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'win32-shortcut'
  spec.version    = '0.2.5'
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Artistic 2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'http://github.com/djberg96/win32-shortcut'
  spec.summary    = 'An interface for creating or modifying Windows shortcuts.'
  spec.test_file  = 'test/test_shortcut.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = Dir['certs/*']

  spec.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']

  spec.description = <<-EOF
    The win32-shortcut library provides an interface for creating new
    Windows shortcuts or querying information about existing shortcuts.
  EOF
end
