require 'rubygems'

spec = Gem::Specification.new do |gem|
   gem.name      = 'win32-shortcut'
   gem.version   = '0.2.3'
   gem.author    = 'Daniel J. Berger'
   gem.license   = 'Artistic 2.0'
   gem.email     = 'djberg96@gmail.com'
   gem.homepage  = 'http://www.rubyforge.org/projects/win32utils'
   gem.platform  = Gem::Platform::RUBY
   gem.summary   = 'An interface for creating or modifying Windows shortcuts.'
   gem.test_file = 'test/test_shortcut.rb'
   gem.has_rdoc  = true
   gem.files     = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.rubyforge_project = 'win32utils'
   gem.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']

   gem.description = <<-EOF
      The win32-shortcut library provides an interface for creating new
      Windows shortcuts or querying information about existing shortcuts.
   EOF
end

Gem::Builder.new(spec).build
