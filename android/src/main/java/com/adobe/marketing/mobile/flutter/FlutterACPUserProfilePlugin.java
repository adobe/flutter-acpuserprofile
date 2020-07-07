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

package com.adobe.marketing.mobile.flutter;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.adobe.marketing.mobile.AdobeCallback;
import com.adobe.marketing.mobile.UserProfile;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/** FlutterACPUserProfilePlugin */
public class FlutterACPUserProfilePlugin implements MethodCallHandler {

  private String TAG = "FlutterACPUserProfilePlugin";

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_acpuserprofile");
    channel.setMethodCallHandler(new FlutterACPUserProfilePlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if ("extensionVersion".equals(call.method)) {
      result.success(UserProfile.extensionVersion());
    } else if ("getUserAttributes".equals((call.method))) {
      handleGetUserAttributes(call.arguments, result);
    } else if ("removeUserAttribute".equals((call.method))) {
      handleRemoveUserAttribute(call.arguments);
      result.success(null);
    } else if ("removeUserAttributes".equals(call.method)) {
      handleRemoveUserAttributes(call.arguments);
      result.success(null);
    } else if ("updateUserAttribute".equals((call.method))) {
      handleUpdateUserAttribute(call.arguments);
      result.success(null);
    } else if ("updateUserAttributes".equals((call.method))) {
      handleUpdateUserAttributes(call.arguments);
      result.success(null);
    } else {
      result.notImplemented();
    }
  }

  private void handleGetUserAttributes(Object arguments, final Result result) {
    if (!(arguments instanceof List)) {
      Log.e(TAG, "Get user attributes failed because arguments were invalid");
      return;
    }
    List<String> attributes = (List) arguments;
    UserProfile.getUserAttributes(attributes, new AdobeCallback<Map<String, Object>>() {
      @Override
      public void call(Map<String, Object> retrievedAttributes) {
        if(retrievedAttributes != null) {
          final JSONArray jsonArray = new JSONArray();
          JSONObject json;
          int index = 0;
          try {
            Iterator it = retrievedAttributes.entrySet().iterator();
            while(it.hasNext())
            {
              json = new JSONObject();
              Map.Entry<String,Object> entry = (Map.Entry<String,Object>)it.next();
              json.put(entry.getKey(), entry.getValue());
              jsonArray.put(index, json);
              index++;
            }
          } catch (JSONException e){
            Log.d(TAG, "Error putting data into JSON: " + e.getLocalizedMessage());
          }
          runOnUIThread(new Runnable() {
            @Override
            public void run() {
              result.success(jsonArray.toString());
            }
          });
        } else {
          runOnUIThread(new Runnable() {
            @Override
            public void run() {
              result.error(null, "Error retrieving user attributes", null);
            }
          });
        }
      }
    });
  }

  private void handleRemoveUserAttributes(Object arguments) {
    if (!(arguments instanceof List)) {
      Log.e(TAG, "Removing user attributes failed because arguments were invalid");
      return;
    }
    List<String> attributes = (List) arguments;
    UserProfile.removeUserAttributes(attributes);
  }

  private void handleRemoveUserAttribute(Object arguments) {
    if (arguments instanceof String) {
      UserProfile.removeUserAttribute((String) arguments);
    }
  }

  private void handleUpdateUserAttribute(Object arguments) {
    if (!(arguments instanceof Map) || !((Map) arguments).containsKey("attributeName") || !((Map) arguments).containsKey("attributeValue")) {
      Log.e(TAG, "Update User Attribute failed because arguments were invalid");
      return;
    }

    Map<String, Object> params = (Map<String, Object>) arguments;
    String attributeName = (String) params.get("attributeName");
    String attributeValue = (String) params.get("attributeValue");

    UserProfile.updateUserAttribute(attributeName, attributeValue);
  }

  private void handleUpdateUserAttributes(Object arguments) {
    if (!(arguments instanceof Map)) {
      Log.e(TAG, "Update User Attributes failed, arguments are invalid");
      return;
    }

    Map params = (Map) arguments;
    UserProfile.updateUserAttributes(params);
  }

  void runOnUIThread(Runnable runnable) {
    new Handler(Looper.getMainLooper()).post(runnable);
  }
}
