require 'rake'
require 'rake/testtask'

desc "Install the win32-shortcut library (non-gem)"
task :install do
   dest = File.join(Config::CONFIG['sitelibdir'], 'win32')
   Dir.mkdir(dest) unless File.exists? dest
   cp 'lib/win32/shortcut.rb', dest, :verbose => true
end

desc "Install the win32-shortcut library as a gem"
task :install_gem do
   ruby 'win32-shortcut.gemspec'
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

Rake::TestTask.new do |t|
   t.warning = true
   t.verbose = true
end
