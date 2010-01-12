###########################################################################
# example_shortcut.rb
#
# This will create a shortcut on your desktop to the the Notepad
# application.  Please delete when finished.
############################################################################
Dir.chdir('..') if File.basename(Dir.pwd) == 'examples'
$LOAD_PATH.unshift(Dir.pwd + '/lib')

require 'win32/shortcut'
require 'win32/dir'
include Win32

puts Shortcut::VERSION

Shortcut.new(Dir::DESKTOP + '\Shortcut Script.lnk') do |s|
   s.path = "c:\\" << Dir::WINDOWS << "\\notepad.exe"
   s.window_style = Shortcut::SHOWNORMAL
   s.hotkey = "CTRL+SHIFT+F"
   s.icon_location = "notepad.exe"
   s.description = "Shortcut Script"
   s.working_directory = Dir::DESKTOP
end

sc = Shortcut.open(Dir::DESKTOP + '\Shortcut Script.lnk')
p sc.path
p sc.window_style
p sc.hotkey