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

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_acpuserprofile/flutter_acpuserprofile.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_acpuserprofile');

  TestWidgetsFlutterBinding.ensureInitialized();

  group('extensionVersion', () {
    final String testVersion = "1.1.0";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testVersion;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPUserProfile.extensionVersion;

      expect(log, <Matcher>[
        isMethodCall(
          'extensionVersion',
          arguments:null,
        ),
      ]);
    });

    test('returns correct result', () async {
      expect(await FlutterACPUserProfile.extensionVersion, testVersion);
    });
  });

  group('getUserAttributes', () {
    final String testUserAttributes = "userAttributes";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testUserAttributes;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPUserProfile.getUserAttributes([testUserAttributes]);

      expect(log, <Matcher>[
        isMethodCall(
          'getUserAttributes',
          arguments:[testUserAttributes],
        ),
      ]);
    });

    test('returns correct result', () async {
      String userAttributes = await FlutterACPUserProfile.getUserAttributes([testUserAttributes]);
      expect(userAttributes, testUserAttributes);
    });
  });

  group('removeUserAttribute', () {
    final String testUserAttribute = "userAttribute";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPUserProfile.removeUserAttribute(testUserAttribute);

      expect(log, <Matcher>[
        isMethodCall(
          'removeUserAttribute',
          arguments:testUserAttribute,
        ),
      ]);
    });
  });

  group('removeUserAttributes', () {
    final String testUserAttribute = "userAttribute";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPUserProfile.removeUserAttributes([testUserAttribute]);

      expect(log, <Matcher>[
        isMethodCall(
          'removeUserAttributes',
          arguments:[testUserAttribute],
        ),
      ]);
    });
  });

  group('updateUserAttribute', () {
    final String testUserAttribute = "userAttribute";
    final String testUserAttributeValue = "userAttributeValue";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPUserProfile.updateUserAttribute(testUserAttribute, testUserAttributeValue);

      expect(log, <Matcher>[
        isMethodCall(
          'updateUserAttribute',
          arguments: { "attributeName" : testUserAttribute, "attributeValue" : testUserAttributeValue },
        ),
      ]);
    });
  });

  group('updateUserAttribute', () {
    final Map<String, Object> testUserAttribute = {"testKey":"testValue"};
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPUserProfile.updateUserAttributes(testUserAttribute);

      expect(log, <Matcher>[
        isMethodCall(
          'updateUserAttributes',
          arguments: testUserAttribute,
        ),
      ]);
    });
  });

}
