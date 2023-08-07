# flutter_acpuserprofile

## Notice of deprecation

Since *April 25, 2023*, [Apple has required](https://developer.apple.com/news/?id=jd9wcyov) apps submitted to the App Store to be built with Xcode 14.1 or later. The Experience Platform Mobile SDKs and extensions outlined below were built with prior versions of Xcode and are no longer compatible with iOS and iPadOS given Apple’s current App Store requirements. Consequently, on *August 31, 2023*, Adobe will be deprecating support for the following Experience Platform Mobile SDKs and wrapper extensions:

- [ACP iOS SDK](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#ios)
- [Cordova](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#cordova)
- [Flutter for ACP](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#flutter)
- [React Native for ACP](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#react-native)
- [Xamarin](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#xamarin)

After *August 31, 2023*, applications already submitted to the App Store that contain these SDKs and wrapper extensions will continue to operate, however, Adobe will not be providing security updates or bug fixes, and these SDKs and wrapper extensions will be provided as-is exclusive of any warranty, due to the App Store policy outlined above.

We encourage all customers to migrate to the latest Adobe Experience Platform versions of the Mobile SDK to ensure continued compatibility and support. Documentation for the latest versions of the Adobe Experience Platform Mobile SDKs can be found [here](https://developer.adobe.com/client-sdks/documentation/current-sdk-versions/). The iOS migration guide can be found [here](https://developer.adobe.com/client-sdks/previous-versions/documentation/migrate-to-swift/).

---

[![pub package](https://img.shields.io/pub/v/flutter_acpuserprofile.svg)](https://pub.dartlang.org/packages/flutter_acpuserprofile) ![Build](https://github.com/adobe/flutter-acpuserprofile/workflows/Dart%20Unit%20Tests%20+%20Android%20Build%20+%20iOS%20Build/badge.svg) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

`flutter_acpuserprofile` is a flutter plugin for the iOS and Android [AEP UserProfile SDK](https://developer.adobe.com/client-sdks/previous-versions/documentation/profile/) to allow for integration with flutter applications. Functionality to enable the UserProfile extension is provided entirely through Dart documented below.

## Installation

Add `flutter_acpcore` and `flutter_acpuserprofile` to your dependencies in `pubspec.yaml`

```yaml
dependencies:
  flutter_acpcore: ">= 2.0.0"
  flutter_acpuserprofile: ">= 2.0.0"
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

### UserProfile
##### Importing the SDK:
```dart
import 'package:flutter_acpuserprofile/flutter_acpuserprofile.dart';
```

##### Getting the SDK version:
 ```dart
String version = FlutterACPUserProfile.extensionVersion;
 ```

 ##### Registering the extension with ACPCore:

 > Note: It is required to initialize the SDK via native code inside your AppDelegate and MainApplication for iOS and Android respectively. For more information see how to initialize [Core](https://developer.adobe.com/client-sdks/previous-versions/documentation/mobile-core/api-reference/#registerextensions).

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
