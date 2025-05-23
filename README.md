# save_to_folder_ios

An iOS native file saving plugin.  
Allows users to open the native iOS Files app, choose a destination folder, and copy (save) a specified file to that location.

![exapme gif](https://raw.githubusercontent.com/travelwithme232/save_to_folder_ios/main/output1.gif)

## Features

- Uses iOS UIDocumentPickerViewController on iOS 14 and above
- Uses iOS UIActivityViewController on iOS 13 and below
- User selects the save location directly
- Sends the result (true or false) back to Flutter

## Usage

```dart
import 'package:save_to_folder_ios/save_to_folder_ios.dart';

final filePath = '/path/to/your/file.txt';

bool success = await SaveToFolderIos.copy(filePath);

if (success) {
  print('File saved successfully!');
} else {
  print('File save cancelled or failed.');
}
```

## Notes

- `filePath` must be a valid, accessible path within the iOS app sandbox.
- Testing on a real device is recommended, as the simulator may not fully support file picker features.

## Optional: Show Your App’s Document Folder in the iOS Files App

If you want your app's document folder to appear in the native Files app:

Add the following entries to your `Info.plist` file:

```xml
<key>LSSupportsOpeningDocumentsInPlace</key>
<true/>
<key>UIFileSharingEnabled</key>
<true/>
```

