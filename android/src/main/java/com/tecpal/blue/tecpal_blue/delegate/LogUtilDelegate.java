package com.tecpal.blue.tecpal_blue.delegate;

import androidx.annotation.NonNull;

import com.tecpal.blue.tecpal_blue.LogUtils;
import com.tecpal.blue.tecpal_blue.constant.GlobalConstant;

import java.util.Arrays;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @NAME: LogUtilDelegate
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/16 16:01
 * @PROJECT_NAME: android
 */
public class LogUtilDelegate extends CallDelegate{

    private static List<String> supportedMethods = Arrays.asList(GlobalConstant.MethodName.LOG_SMING);

    public LogUtilDelegate() {
        super(supportedMethods);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals(GlobalConstant.MethodName.LOG_SMING)) {
            String arguments = (String) call.arguments;
            LogUtils.Sming(arguments);
        }
    }
}
