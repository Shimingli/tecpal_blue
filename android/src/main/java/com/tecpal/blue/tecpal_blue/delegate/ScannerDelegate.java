package com.tecpal.blue.tecpal_blue.delegate;

import androidx.annotation.NonNull;

import com.tecpal.blue.tecpal_blue.LogUtils;
import com.tecpal.blue.tecpal_blue.ble.BleAdapter;
import com.tecpal.blue.tecpal_blue.callback.OnErrorCallback;
import com.tecpal.blue.tecpal_blue.callback.OnEventCallback;
import com.tecpal.blue.tecpal_blue.callback.OnSuccessCallback;
import com.tecpal.blue.tecpal_blue.constant.GlobalConstant;
import com.tecpal.blue.tecpal_blue.converter.BleErrorJsonConverter;
import com.tecpal.blue.tecpal_blue.entity.ScanResultEntity;
import com.tecpal.blue.tecpal_blue.error.BleError;

import java.util.Arrays;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author : ShiMing
 * @editor :
 * @description :
 * @created : 2022-03-24 11:17
 */
public class ScannerDelegate extends CallDelegate {

    private static List<String> supportedMethods = Arrays.asList(
            GlobalConstant.MethodName.START_DEVICE_SCAN,
            GlobalConstant.MethodName.STOP_DEVICE_SCAN);

    private final BleAdapter bleAdapter;
    private final BleErrorJsonConverter bleErrorJsonConverter = new BleErrorJsonConverter();

    public ScannerDelegate(BleAdapter bleAdapter) {
        super(supportedMethods);
        this.bleAdapter = bleAdapter;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {

        LogUtils.Sming("onMethodCall  methodCall.method " + methodCall.method);
        switch (methodCall.method) {
            case GlobalConstant.MethodName.START_DEVICE_SCAN:
                startDeviceScan(methodCall, result);
                return;
            case GlobalConstant.MethodName.STOP_DEVICE_SCAN:
                return;
        }
    }

    private void startDeviceScan(MethodCall methodCall, MethodChannel.Result result) {
        List<String> uuids = methodCall.<List<String>>argument(GlobalConstant.ArgumentKey.UUIDS);
        Integer argument = methodCall.<Integer>argument(GlobalConstant.ArgumentKey.SCAN_MODE);
        Integer callback = methodCall.<Integer>argument(GlobalConstant.ArgumentKey.CALLBACK_TYPE);

        LogUtils.Sming(" startDeviceScan  " + uuids);
        LogUtils.Sming(" startDeviceScan argument  " + argument);
        LogUtils.Sming(" startDeviceScan callback  " + callback);

        bleAdapter.startDeviceScan(new OnEventCallback<ScanResultEntity>() {
            @Override
            public void onEvent(ScanResultEntity data) {

            }
        }, new OnErrorCallback() {
            @Override
            public void onError(BleError error) {

            }
        });
    }

    static class ScanMode {
        int opportunistic = -1;
        int lowPower = 0;
        int balanced = 1;
        int lowLatency = 2;
    }

    static class CallbackType {
        int allMatches = 1;
        int firstMatch = 2;
        int matchLost = 4;
    }

}

