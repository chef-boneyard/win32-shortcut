require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem")

namespace :gem do
  desc "Create theh win32-shortcut gem" 
  task :create => [:clean] do
    spec = eval(IO.read('win32-shortcut.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc "Install the win32-shortcut gem"
  task :install => [:create] do
    ruby 'win32-shortcut.gemspec'
    file = Dir["*.gem"].first
    sh "gem install #{file}"
  end
end

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
end

task :default => :test
