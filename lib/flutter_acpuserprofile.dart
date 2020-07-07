import 'dart:async';

import 'package:flutter/services.dart';

class FlutterACPUserProfile {
  static const MethodChannel _channel =
      const MethodChannel('flutter_acpuserprofile');

  /// Gets the current User Profile extension version.
  static Future<String> get extensionVersion async {
    final String version = await _channel.invokeMethod('extensionVersion');
    return version;
  }

  /// UserProfile API to remove the give attribute name
  static Future<void> removeUserAttribute(String attributeName) async {
    await _channel.invokeMethod<void>('removeUserAttribute', attributeName ?? "");
  }

  /// UserProfile API to set user profile attributes keys and values.
  static Future<void> updateUserAttribute(String attributeName, String attributeValue) async {
    await _channel.invokeMethod<void>('updateUserAttribute', {"attributeName" : attributeName ?? "", "attributeValue" : attributeValue ?? ""});
  }

  /// UserProfile API to set user profile attributes keys and values.
  static Future<void> updateUserAttributes(Map<String, Object> attributeMap) async {
    await _channel.invokeMethod<void>('updateUserAttributes', attributeMap ?? {});
  }
}
