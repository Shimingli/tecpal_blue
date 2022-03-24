package com.tecpal.blue.tecpal_blue.delegate;

import androidx.annotation.NonNull;

import com.tecpal.blue.tecpal_blue.ble.BleAdapter;
import com.tecpal.blue.tecpal_blue.callback.OnErrorCallback;
import com.tecpal.blue.tecpal_blue.callback.OnSuccessCallback;
import com.tecpal.blue.tecpal_blue.constant.GlobalConstant;
import com.tecpal.blue.tecpal_blue.converter.BleErrorJsonConverter;
import com.tecpal.blue.tecpal_blue.error.BleError;

import java.util.Arrays;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author : ShiMing
 * @editor :
 * @description :
 * @created : 2022-03-22 11:42
 */
public class BluetoothStateDelegate extends CallDelegate {

    private static List<String> supportedMethods = Arrays.asList(
            GlobalConstant.MethodName.ENABLE_RADIO,
            GlobalConstant.MethodName.DISABLE_RADIO,
            GlobalConstant.MethodName.GET_STATE);

    private final BleAdapter bleAdapter;
    private final BleErrorJsonConverter bleErrorJsonConverter = new BleErrorJsonConverter();

    public BluetoothStateDelegate(BleAdapter bleAdapter) {
        super(supportedMethods);
        this.bleAdapter = bleAdapter;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        switch (methodCall.method) {
            case GlobalConstant.MethodName.ENABLE_RADIO:
                enableRadio(methodCall.<String>argument(GlobalConstant.ArgumentKey.TRANSACTION_ID), result);
                return;
            case GlobalConstant.MethodName.DISABLE_RADIO:
                disableRadio(methodCall.<String>argument(GlobalConstant.ArgumentKey.TRANSACTION_ID), result);
                return;
            case GlobalConstant.MethodName.GET_STATE:
                getState(result);
                return;
            default:
                throw new IllegalArgumentException(methodCall.method + " cannot be handle by this delegate");
        }
    }

    private void enableRadio(String transactionId, @NonNull final MethodChannel.Result result) {
        bleAdapter.enable(transactionId,
                new OnSuccessCallback<Void>() {
                    @Override
                    public void onSuccess(Void data) {
                        result.success(null);
                    }
                }, new OnErrorCallback() {
                    @Override
                    public void onError(BleError error) {
                        result.error(String.valueOf(error.errorCode.code), error.reason, bleErrorJsonConverter.toJson(error));
                    }
                });
    }

    private void disableRadio(String transactionId, @NonNull final MethodChannel.Result result) {
        bleAdapter.disable(transactionId,
                new OnSuccessCallback<Void>() {
                    @Override
                    public void onSuccess(Void data) {
                        result.success(null);
                    }
                }, new OnErrorCallback() {
                    @Override
                    public void onError(BleError error) {
                        result.error(String.valueOf(error.errorCode.code), error.reason, bleErrorJsonConverter.toJson(error));
                    }
                });
    }

    private void getState(@NonNull final MethodChannel.Result result) {
        result.success(bleAdapter.getCurrentState());
    }

}