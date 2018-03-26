# xojo-modern-preferences
A Xojo module for storing application preferences as JSON using the new framework. Adapted from Paul Lefebvre's `PreferencesModule` but uses Xojo's new framework classes such as `Xojo.IO.FolderItem`, `Text` instead of `String`, `Xojo.Core.Dictionary` instead of `JSONItem` and `Auto` instead of `Variant`. The original implementation can be found on the Xojo blog here: [https://blog.xojo.com/2014/01/27/saving-preferences/](https://blog.xojo.com/2014/01/27/saving-preferences/).

## Usage
1. Drop the `ModernPreference` module into your project.
2. Initialise the module in the `Open` event of your application by passing it the name of your application (`APP_NAME`):

```xojo
ModernPreferences.Initialise("ModernPreferencesExample")

' Now you can load the preferences

if not Preferences.Load() then
  ' Set default values for preferences so that they 
  ' do not cause a PreferencesNotFoundException when accessed.
  Preferences.UserID = "Default"
end if
```

3. You can add new/update existing keys in the preferences file using operator overloading. For example, to assign `"Garry"` to the `"UserID"` key you'd do the following:

```xojo
Preferences.UserID = "Garry"
```

4. Save the preferences by calling `Preferences.Save()`