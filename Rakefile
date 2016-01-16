require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem")

namespace :gem do
  desc "Create theh win32-shortcut gem" 
  task :create => [:clean] do
    require 'rubygems/package'
    spec = eval(IO.read('win32-shortcut.gemspec'))
    spec.signing_key = File.join(Dir.home, '.ssh', 'gem-private_key.pem')
    Gem::Package.build(spec, true)
  end

  desc "Install the win32-shortcut gem"
  task :install => [:create] do
    ruby 'win32-shortcut.gemspec'
    file = Dir["*.gem"].first
    sh "gem install -l #{file}"
  end
end

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
end

task :default => :test
