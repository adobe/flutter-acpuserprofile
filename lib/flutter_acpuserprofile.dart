/*
Copyright 2020 Adobe. All rights reserved.
This file is licensed to you under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
OF ANY KIND, either express or implied. See the License for the specific language
governing permissions and limitations under the License.
*/

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

  /// Gets the current User Profile extension version.
  static Future<String> getUserAttributes(List<String> attributeKeys) async {
    final String userAttributes = await _channel.invokeMethod('getUserAttributes', attributeKeys ?? "");
    return userAttributes;
  }

  /// UserProfile API to remove the given attribute name
  static Future<void> removeUserAttribute(String attributeName) async {
    await _channel.invokeMethod<void>('removeUserAttribute', attributeName ?? "");
  }

  /// UserProfile API to remove the given attribute name
  static Future<void> removeUserAttributes(List<String> attributeName) async {
    await _channel.invokeMethod<void>('removeUserAttributes', attributeName ?? "");
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
