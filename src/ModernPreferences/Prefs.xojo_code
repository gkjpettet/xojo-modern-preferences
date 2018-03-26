#tag Class
Private Class Prefs
	#tag Method, Flags = &h0
		Sub Constructor(appName As Text)
		  mPreferences = new Xojo.Core.Dictionary
		  mAppName = appName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(name As Text) As Auto
		  ' Allow lookup of preference using this syntax:
		  ' Dim top As Integer = Preferences.Get("MainWindowTop")
		  
		  if mPreferences <> Nil then
		    if mPreferences.HasKey(name) then
		      return mPreferences.Value(name)
		    else
		      raise new PreferenceNotFoundException(name)
		    end if
		  else
		    return -1
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Load() As Boolean
		  dim prefFolder as Xojo.IO.FolderItem = Xojo.IO.SpecialFolder.ApplicationSupport.Child(mAppName)
		  if not prefFolder.Exists then
		    prefFolder.CreateAsFolder()
		  end if
		  
		  dim prefName as Text = mAppName + ".prefs"
		  
		  mPreferencesFile = prefFolder.Child(prefName)
		  
		  if mPreferencesFile.Exists then
		    
		    dim input as Xojo.IO.TextInputStream
		    input = Xojo.IO.TextInputStream.Open(mPreferencesFile, Xojo.Core.TextEncoding.UTF8)
		    
		    dim data as Text = input.ReadAll()
		    input.Close()
		    
		    try
		      mPreferences = Xojo.Data.ParseJSON(data)
		      return True
		    catch e as Xojo.Data.InvalidJSONException
		      return False
		    end try
		    
		  else
		    return False
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Lookup(name As Text) As Auto
		  // Allow lookup of preference using this syntax:
		  // Dim top As Integer = Preferences.MainWindowTop
		  
		  return Get(name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Lookup(name as Text, assigns value as Auto)
		  // Set a preference using this syntax:
		  // Preferences.MainWindowTop = 345
		  
		  Set(name) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save() As Boolean
		  if mPreferencesFile <> Nil then
		    dim data as Text = Xojo.Data.GenerateJSON(mPreferences)
		    
		    try
		      dim output as Xojo.IO.TextOutputStream
		      output = Xojo.IO.TextOutputStream.Create(mPreferencesFile, Xojo.Core.TextEncoding.UTF8)
		      
		      output.Write(data)
		      
		      return True
		    Catch e as IOException
		      return False
		    end try
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(name as Text, assigns value as Auto)
		  if mPreferences <> Nil then
		    ' Set a preference using this syntax:
		    ' Preferences.Set("MainWindowTop") = 345
		    mPreferences.Value(name) = value
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAppName As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		mPreferences As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreferencesFile As Xojo.IO.FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
