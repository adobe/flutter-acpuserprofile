package com.adobe.marketing.mobile.flutter;

import android.util.Log;

import com.adobe.marketing.mobile.UserProfile;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.HashMap;
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
    } else if ("removeUserAttribute".equals((call.method))) {
      handleRemoveUserAttribute(call.arguments);
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
}
