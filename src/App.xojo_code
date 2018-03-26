#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  // Save the preferences when the app quits. You can do this at any time, of course.
		  If Not Preferences.Save Then
		    MsgBox("Could not save preferences.")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  ' Initialize the preferences by telling it the name of your app.
		  ' Preferences will be stored in the SpecialFolder.ApplicationData
		  ' in a folder with the app name in a file ending in ".prefs".
		  ' So the below example would have preferences saved in:
		  ' ApplicationData/ModernPreferencesExample/ModernPreferencesExample.prefs
		  
		  ModernPreferences.Initialise("ModernPreferencesExample")
		  
		  ' Now you can load the preferences
		  
		  if not Preferences.Load() then
		    ' Set default values for preferences so that they 
		    ' do not cause a PreferencesNotFoundException when accessed.
		    Preferences.UserID = "Default"
		  end if
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
