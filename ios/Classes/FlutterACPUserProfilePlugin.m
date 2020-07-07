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

#import "FlutterACPUserProfilePlugin.h"
#import "ACPUserProfile.h"

@implementation FlutterACPUserProfilePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_acpuserprofile"
            binaryMessenger:[registrar messenger]];
  FlutterACPUserProfilePlugin* instance = [[FlutterACPUserProfilePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"extensionVersion" isEqualToString:call.method]) {
        result([ACPUserProfile extensionVersion]);
    } else if ([@"getUserAttributes" isEqualToString:call.method]) {
        [self handleGetUserAttributes:call result:result];
    } else if ([@"removeUserAttribute" isEqualToString:call.method]) {
        NSString *attributeName = call.arguments;
        [ACPUserProfile removeUserAttribute:attributeName];
        result(nil);
    } else if ([@"removeUserAttributes" isEqualToString:call.method]) {
        NSArray<NSString*>* userAttributes = call.arguments;
        [ACPUserProfile removeUserAttributes:userAttributes];
        result(nil);
    } else if ([@"updateUserAttribute" isEqualToString:call.method]) {
        NSDictionary *dict = (NSDictionary *) call.arguments;
        NSString *attributeName = (NSString *) dict[@"attributeName"];
        NSString *attributeValue = (NSString *) dict[@"attributeValue"];
        [ACPUserProfile updateUserAttribute:attributeName withValue:attributeValue];
        result(nil);
    } else if ([@"updateUserAttributes" isEqualToString:call.method]) {
        NSDictionary *attributeMap = call.arguments;
        [ACPUserProfile updateUserAttributes:attributeMap];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)handleGetUserAttributes:(FlutterMethodCall *) call result:(FlutterResult)result {
    NSArray<NSString*>* userAttributesToRetrieve = call.arguments;
    [ACPUserProfile getUserAttributes:userAttributesToRetrieve withCompletionHandler:^(NSDictionary* _Nullable userAttributes, NSError* error) {
        if(userAttributes != nil && userAttributes.count != 0) {
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userAttributes options:0 error:nil];
            result([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        }
        if(error){
            result([NSString stringWithFormat:@"User profile request error code: %@", error]);
        }
    }];
}

@end
