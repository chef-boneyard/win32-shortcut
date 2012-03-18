require 'win32ole'

# The Win32 module serves as a namespace only.
module Win32
  # The Shortcut class encapsulates an MS Windows shortcut.
  class Shortcut
    # The version of this library
    VERSION = '0.2.4'

    # Activates and displays a window. If the window is minimized or maximized,
    # the system restores it to its original size and position. An application
    # should specify this flag when displaying the window for the first time.
    #
    SHOWNORMAL = 1

    # Activates the window and displays it as a maximized window.
    #
    SHOWMAXIMIZED = 3

    # Displays the window in its minimized state, leaving the currently active
    # window as active.
    #
    SHOWMINNOACTIVE = 7

    # Creates and returns a Shortcut object. In block form it yields +self+
    # and automatically ensures that Shortcut#save is called at the end of
    # the block. In non-block form it does not actually create the shortcut
    # until the Shorcut#save method is called.
    #
    # Examples:
    #
    #   # Create a shortcut called 'test' to a file in non-block form.
    #   s = Shortcut.new('test.lnk')
    #   s.target_path = 'C:/Documents and Settings/john/some_file.txt'
    #   s.save
    #
    #   # Create a shortcut called 'test2' to a folder in block form.
    #   Shortcut.new('test2.lnk') do |sc|
    #      sc.target_path = 'C:/Documents and Settings/john/some_dir'
    #   end
    #
    def initialize(file)
      @file  = file.tr('/', "\\")
      @shell = WIN32OLE.new('WScript.Shell')
      @link  = @shell.CreateShortcut(@file)

      if block_given?
        begin
          yield self
        ensure
          save
        end
      end
    end

    # Identical to Shortcut#new except that it will raise an ArgumentError
    # unless the +file+ already exists.
    #
    def self.open(file)
      raise ArgumentError, 'shortcut not found' unless File.exists?(file)
      self.new(file)
    end

    # Returns any arguments (i.e. command line options) for the shortcut.
    #
    def arguments
      @link.Arguments
    end

    # Sets the arguments (i.e. command line options) for the shortcut.
    #
    def arguments=(args)
      @link.Arguments = args
    end

    # Returns the description (i.e. comment) for the shortcut.
    #
    def description
      @link.Description
    end

    # Sets the description for the shortcut.
    #
    def description=(desc)
      @link.Description = desc
    end

    # Returns the file name of the shortcut.
    #
    def file
      @file
    end

    # Returns the hotkey (i.e. shortcut key) associated to the shortcut, in
    # the form of a 2-byte number of which the first byte identifies the
    # modifiers (Ctrl, Alt, Shift) and the second is the ASCII code of
    # the character key.
    #
    def hotkey
      @link.HotKey
    end

    # Sets the hotkey for the shortcut.
    #
    def hotkey=(key)
      @link.HotKey = key
    end

    # Returns the name of the file that contain the icon for the shortcut.
    # In practice this is almost always blank.  YMMV.
    #
    def icon_location
      @link.IconLocation
    end

    # Sets the name of the icon file to be used for the shortcut.
    #
    def icon_location=(location)
      @link.IconLocation = location.tr('/', "\\")
    end

    # Returns the target of the shortcut. This is, joined with arguments, the
    # content of the "Target" field in a Shortcut Properties Dialog Box. The
    # target name is returned in 8.3 format.
    #
    def path
      @link.TargetPath
    end

    alias target_path path

    # Sets the target of the shortcut.
    #--
    # Forward slashes are converted to backslashes to ensure folder
    # shortcuts work properly.
    #
    def path=(link_path)
      @link.TargetPath = link_path.tr('/', "\\")
    end

    alias target_path= path=

    # Attempts to automatically resolve a shortcut and returns the resolved path,
    # or raises an error.  In case no resolution was made, the path is returned
    # unchanged.
    #
    # Note that the path is automatically updated in the path attribute of the
    # Shortcut object.
    #
    def resolve
      @link.FullName
    end

    # Returns the type of window style used by a shortcut.  The possible
    # return values are 'normal', 'maximized', or 'minimized'.
    #
    def window_style
      case @link.WindowStyle
        when SHOWNORMAL
          'normal'
        when SHOWMAXIMIZED
          'maximized'
        when SHOWMINNOACTIVE
          'minimized'
        else
         'unknown' # Should never reach here
      end
    end

    # Deprecated.
    alias show_cmd window_style

    # Sets the window style to a shortcut.  The +style+ can be one of the
    # following three constants or equivalent string values:
    #
    # * SHOWNORMAL      or 'normal'
    # * SHOWMAXIMIZED   or 'maximized'
    # * SHOWMINNOACTIVE or 'minimized'
    #
    # Please see the documentation for those constants for further details.
    #
    def window_style=(style)
      valid = [SHOWNORMAL, SHOWMAXIMIZED, SHOWMINNOACTIVE]
      valid.concat(['normal', 'maximized', 'minimized'])

      unless valid.include?(style)
        raise ArgumentError, 'invalid style'
      end

      if style.is_a?(String)
        case style.downcase
          when 'normal'
            style = SHOWNORMAL
          when 'maximized'
            style = SHOWMAXIMIZED
          when 'minimized'
            style = SHOWMINNOACTIVE
        end
      end

      @link.WindowStyle = style
    end

    # Deprecated.
    alias show_cmd= window_style=

    # Returns directory in which the targeted program will be executed.
    # Correspond to the "Start in" field of a Shortcut Properties Dialog Box.
    #
    def working_directory
      @link.WorkingDirectory
    end

    # Sets the directory in which the targeted program will be executed.
    #
    def working_directory=(directory)
      @link.WorkingDirectory = directory.tr('/', "\\")
    end

    # Saves (creates) the link object in the current directory.
    #
    def save
      @link.Save
    end
  end
end
