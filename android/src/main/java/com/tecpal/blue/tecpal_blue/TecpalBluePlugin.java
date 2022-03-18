package com.tecpal.blue.tecpal_blue;

import androidx.annotation.NonNull;

import com.tecpal.blue.tecpal_blue.ble.BleAdapter;
import com.tecpal.blue.tecpal_blue.ble.BleAdapterFactory;
import com.tecpal.blue.tecpal_blue.constant.GlobalConstant;
import com.tecpal.blue.tecpal_blue.delegate.CallDelegate;
import com.tecpal.blue.tecpal_blue.delegate.LogUtilDelegate;
import com.tecpal.blue.tecpal_blue.event.TestStreamHandler;

import java.util.LinkedList;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;



/**
 * TecpalBluePlugin
 */
public class TecpalBluePlugin implements FlutterPlugin, MethodCallHandler {

    private MethodChannel channel;
    private EventChannel eventChannel;
    private BleAdapter bleAdapter;
    private List<CallDelegate> delegates = new LinkedList<>();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), GlobalConstant.ChannelName.FLUTTER_BLE_LIB);
        channel.setMethodCallHandler(this);

        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), GlobalConstant.ChannelName.FLUTTER_BLE_LIB_TEST);
        eventChannel.setStreamHandler(new TestStreamHandler(flutterPluginBinding.getApplicationContext()));

        LogUtils.Sming("onAttachedToEngine");
        setupAdapter(flutterPluginBinding);
    }

    private void setupAdapter(FlutterPluginBinding flutterPluginBinding) {
        bleAdapter = BleAdapterFactory.getNewAdapter(flutterPluginBinding.getApplicationContext());
        delegates.add(new LogUtilDelegate());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        for (CallDelegate delegate : delegates) {
            if (delegate.canHandle(call)) {
                delegate.onMethodCall(call, result);
                return;
            }
        }

        switch (call.method) {
            case GlobalConstant.MethodName.CREATE_CLIENT:
                break;
            case GlobalConstant.MethodName.DESTROY_CLIENT:
                break;
            case GlobalConstant.MethodName.START_DEVICE_SCAN:
                break;
            case GlobalConstant.MethodName.STOP_DEVICE_SCAN:
                break;
            case GlobalConstant.MethodName.CANCEL_TRANSACTION:
                break;
            case GlobalConstant.MethodName.IS_CLIENT_CREATED:
                isClientCreated(result);
                break;
            default:
                result.notImplemented();
        }

        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    private void isClientCreated(Result result) {
        result.success(bleAdapter != null);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        LogUtils.Sming("onDetachedFromEngine");
        eventChannel.setStreamHandler(null);
        eventChannel = null;
    }
}
