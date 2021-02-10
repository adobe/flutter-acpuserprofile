# flutter_acpuserprofile

[![pub package](https://img.shields.io/pub/v/flutter_acpuserprofile.svg)](https://pub.dartlang.org/packages/flutter_acpuserprofile) ![Build](https://github.com/adobe/flutter-acpuserprofile/workflows/Dart%20Unit%20Tests%20+%20Android%20Build%20+%20iOS%20Build/badge.svg) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

`flutter_acpuserprofile` is a flutter plugin for the iOS and Android [AEP UserProfile SDK](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/profile) to allow for integration with flutter applications. Functionality to enable the UserProfile extension is provided entirely through Dart documented below.

## Installation

Add `flutter_acpcore` and `flutter_acpuserprofile` to your dependencies in `pubspec.yaml`

```yaml
dependencies:
  flutter_acpcore: ">= 1.0.1"
  flutter_acpuserprofile: ">= 1.0.1"
```

Then fetch the packages with:

```bash
flutter pub get
```

## Tests

Run:

```bash
flutter test
```

## Usage

### [UserProfile](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/profile)

##### Importing the SDK:
```dart
import 'package:flutter_acpuserprofile/flutter_acpuserprofile.dart';
```

##### Getting the SDK version:
 ```dart
String version = FlutterACPUserProfile.extensionVersion;
 ```

 ##### Registering the extension with ACPCore:

 > Note: It is required to initialize the SDK via native code inside your AppDelegate and MainApplication for iOS and Android respectively. For more information see how to initialize [Core](https://aep-sdks.gitbook.io/docs/getting-started/get-the-sdk#2-add-initialization-code).

 ##### **iOS**
 ```objective-c
#import "ACPUserProfile.h"

[ACPUserProfile registerExtension];
 ```

 ##### **Android:**
 ```java
import com.adobe.marketing.mobile.UserProfile;

UserProfile.registerExtension();
 ```

 ##### Get user profile attributes which match the provided keys:

 ```dart
String userAttributes;

try {
	trackingId = await FlutterACPUserProfile.getUserAttributes(["attrNameTest", "mapKey"]);
} on PlatformException {
	log("Failed to get the user attributes");
}
 ```

 ##### Remove user profile attribute if it exists:

 ```dart
FlutterACPUserProfile.removeUserAttribute("attrNameTest");
 ```

 ##### Remove provided user profile attributes if they exist:

 ```dart
FlutterACPUserProfile.removeUserAttributes(["attrNameTest", "mapKey"]);
 ```

 ##### Set a single user profile attribute:

 ```dart
FlutterACPUserProfile.updateUserAttribute("attrNameTest", "attrValueTest"),
 ```

 ##### Set multiple user profile attributes:

 ```dart
FlutterACPUserProfile.updateUserAttributes({"mapKey": "mapValue", "mapKey1": "mapValue1"});
 ```

## Contributing
See [CONTRIBUTING](CONTRIBUTING.md)

## License
See [LICENSE](LICENSE)
