package com.tecpal.blue.tecpal_blue.delegate;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @NAME: CallDelegate
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/16 16:00
 * @PROJECT_NAME: android
 */
public abstract class CallDelegate implements MethodChannel.MethodCallHandler {

    final List<String> supportedMethods;

    CallDelegate(List<String> supportedMethods) {
        this.supportedMethods = supportedMethods;
    }

    public boolean canHandle(MethodCall call) {
        return supportedMethods.contains(call.method);
    }
}
