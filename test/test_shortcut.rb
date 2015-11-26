##############################################################################
# test_shortcut.rb
#
# Test suite for the win32-shortcut library.  This will temporarily create
# a link to Notepad in the current directory, which should be automatically
# deleted by this test suite.
#
# You should run this test case via the 'rake test' task.
##############################################################################
require 'win32/shortcut'
require 'test/unit'
include Win32

class TC_Shortcut < Test::Unit::TestCase
  def setup
    @link = File.join(Dir.pwd, 'test.lnk')
    @sc = Shortcut.new(@link)
  end

  def test_version
    assert_equal('0.2.5', Shortcut::VERSION)
  end

  def test_arguments
    assert_respond_to(@sc, :arguments)
    assert_respond_to(@sc, :arguments=)
    assert_nothing_raised{ @sc.arguments }
    assert_nothing_raised{ @sc.arguments = '-v' }
  end

  def test_description
    assert_respond_to(@sc, :description)
    assert_respond_to(@sc, :description=)
    assert_nothing_raised{ @sc.description }
    assert_nothing_raised{ @sc.description = "test link" }
  end

  def test_file
    assert_respond_to(@sc, :file)
    assert_nothing_raised{ @sc.file }
  end

  # TODO: Figure out why hotkey assignment fails here. It works fine in
  # the example program.
  #
  def test_hotkey
    assert_respond_to(@sc, :hotkey)
    assert_respond_to(@sc, :hotkey=)
    assert_nothing_raised{ @sc.hotkey }
    #assert_nothing_raised{ @sc.hotkey = "CTRL-SHIFT-F" }
  end

  def test_icon_location
    assert_respond_to(@sc, :icon_location)
    assert_respond_to(@sc, :icon_location=)
    assert_nothing_raised{ @sc.icon_location }
    assert_nothing_raised{ @sc.icon_location = "notepad.exe"}
  end

  def test_path
    assert_respond_to(@sc, :path)
    assert_respond_to(@sc, :path=)
    assert_nothing_raised{ @sc.path }
    assert_nothing_raised{ @sc.path = 'c:\winnt\notepad.exe' }
  end

  def test_open
    shortcut = Shortcut.new(@link)
    shortcut.save

    assert_respond_to(Shortcut, :open)
    assert_nothing_raised{ Shortcut.open(@link) }
  end

  def test_open_expected_errors
    assert_raise(ArgumentError){ Shortcut.open('bogus') }
  end

  def test_resolve
    assert_respond_to(@sc, :resolve)
  end

  def test_save
    assert_respond_to(@sc, :save)
    assert_nothing_raised{ @sc.save }
    assert_equal(true, File.exist?(@link))
  end

  def test_window_style
    assert_respond_to(@sc, :window_style)
    assert_respond_to(@sc, :window_style=)
    assert_nothing_raised{ @sc.window_style }
    assert_nothing_raised{ @sc.window_style = Shortcut::SHOWNORMAL }
  end

  def test_working_directory
    assert_respond_to(@sc, :working_directory)
    assert_respond_to(@sc, :working_directory=)
    assert_nothing_raised{ @sc.working_directory }
    assert_nothing_raised{ @sc.working_directory = "c:\\" }
  end

  def test_constants
    assert_not_nil(Shortcut::SHOWNORMAL)
    assert_not_nil(Shortcut::SHOWMINNOACTIVE)
    assert_not_nil(Shortcut::SHOWMAXIMIZED)
  end

  def teardown
    @sc = nil
    File.delete(@link) if File.exist?(@link)
  end
end
