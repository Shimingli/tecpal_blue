package com.tecpal.blue.tecpal_blue.ble;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;

import com.tecpal.blue.tecpal_blue.callback.OnErrorCallback;
import com.tecpal.blue.tecpal_blue.callback.OnSuccessCallback;
import com.tecpal.blue.tecpal_blue.constant.BluetoothState;
import com.tecpal.blue.tecpal_blue.error.BleError;
import com.tecpal.blue.tecpal_blue.error.BleErrorCode;

/**
 * @NAME: BleModule
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/17 17:54
 * @PROJECT_NAME: android
 */

public class BleModule implements BleAdapter {
    private BluetoothManager bluetoothManager;

    private BluetoothAdapter bluetoothAdapter;
    private Context context;


    public BleModule(Context context) {
        this.context = context;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            bluetoothManager = (BluetoothManager) context.getSystemService(Context.BLUETOOTH_SERVICE);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            bluetoothAdapter = bluetoothManager.getAdapter();
        }
    }

    @Override
    public void enable(String transactionId, OnSuccessCallback<Void> onSuccessCallback, OnErrorCallback onErrorCallback) {
        changeAdapterState(
                BluetoothAdapter.STATE_ON,
                transactionId,
                onSuccessCallback,
                onErrorCallback);
    }

    /**
     * 监听 广播的信息 回调
     * @param state
     * @param transactionId
     * @param onSuccessCallback
     * @param onErrorCallback
     */
    private void changeAdapterState(int state, String transactionId, OnSuccessCallback<Void> onSuccessCallback, OnErrorCallback onErrorCallback) {
        if (bluetoothManager == null) {
            onErrorCallback.onError(new BleError(BleErrorCode.BluetoothStateChangeFailed, "BluetoothManager is null", null));
            return;
        }
        boolean changeSateResult;
        if (state == BluetoothAdapter.STATE_ON) {
            changeSateResult = !bluetoothAdapter.enable();
        } else {
            changeSateResult = !bluetoothAdapter.disable();
        }
        if (changeSateResult) {
            onErrorCallback.onError(new BleError(
                    BleErrorCode.BluetoothStateChangeFailed,
                    String.format("Couldn't set bluetooth adapter state to %s", state +""),
                    null));
        } else {
            onSuccessCallback.onSuccess(null);
        }

    }

    @Override
    public void disable(String transactionId, OnSuccessCallback<Void> onSuccessCallback, OnErrorCallback onErrorCallback) {
        changeAdapterState(
                BluetoothAdapter.STATE_OFF,
                transactionId,
                onSuccessCallback,
                onErrorCallback);
    }

    @Override
    public String getCurrentState() {
        if (!supportsBluetoothLowEnergy()) return BluetoothState.UNSUPPORTED;
        if (bluetoothManager == null) return BluetoothState.POWERED_OFF;
        return mapNativeAdapterStateToLocalBluetoothState(bluetoothAdapter.getState());
    }

    @BluetoothState
    private String mapNativeAdapterStateToLocalBluetoothState(int adapterState) {
        switch (adapterState) {
            case BluetoothAdapter.STATE_OFF:
                return BluetoothState.POWERED_OFF;
            case BluetoothAdapter.STATE_ON:
                return BluetoothState.POWERED_ON;
            case BluetoothAdapter.STATE_TURNING_OFF:
            case BluetoothAdapter.STATE_TURNING_ON:
                return BluetoothState.RESETTING;
            default:
                return BluetoothState.UNKNOWN;
        }
    }

    private boolean supportsBluetoothLowEnergy() {
        return context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE);
    }
}
