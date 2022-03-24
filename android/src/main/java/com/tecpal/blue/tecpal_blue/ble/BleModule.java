package com.tecpal.blue.tecpal_blue.ble;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanFilter;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.ScanSettings;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.tecpal.blue.tecpal_blue.LogUtils;
import com.tecpal.blue.tecpal_blue.callback.OnErrorCallback;
import com.tecpal.blue.tecpal_blue.callback.OnEventCallback;
import com.tecpal.blue.tecpal_blue.callback.OnSuccessCallback;
import com.tecpal.blue.tecpal_blue.constant.BluetoothState;
import com.tecpal.blue.tecpal_blue.error.BleError;
import com.tecpal.blue.tecpal_blue.error.BleErrorCode;
import com.tecpal.blue.tecpal_blue.entity.ScanResultEntity;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

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
     *
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
                    String.format("Couldn't set bluetooth adapter state to %s", state + ""),
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

    @SuppressLint("MissingPermission")
    @Override
    public void startDeviceScan(OnEventCallback<ScanResultEntity> onEventCallback, OnErrorCallback onErrorCallback) {
        if (bluetoothAdapter == null) {
            bluetoothMachine.getScanCallback().onScanFailed(-1);
            return;
        }
        if (!bluetoothAdapter.isEnabled()) {
            bluetoothMachine.getScanCallback().onScanFailed(-1);
            return;
        }
        BluetoothLeScanner scanner = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            scanner = bluetoothAdapter.getBluetoothLeScanner();
        }
        if (scanner == null) {
            bluetoothMachine.getScanCallback().onScanFailed(-1);
            return;
        }
        ScanSettings.Builder settingBuilder = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            settingBuilder = new ScanSettings.Builder();
            settingBuilder.setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                settingBuilder.setMatchMode(ScanSettings.MATCH_MODE_AGGRESSIVE);
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                settingBuilder.setCallbackType(ScanSettings.CALLBACK_TYPE_ALL_MATCHES);
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            settingBuilder.setLegacy(true);
        }
        ScanSettings settings = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            settings = settingBuilder.build();
        }
        cleanupScanner(scanner);
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            ScanFilter build = new ScanFilter.Builder()
                    .build();
            scanner.startScan(toNativeFilters(build), settings, new ScanCallback() {
                @Override
                public void onScanResult(int callbackType, ScanResult result) {
                    super.onScanResult(callbackType, result);
                }

                @Override
                public void onBatchScanResults(List<ScanResult> results) {
                    super.onBatchScanResults(results);
                }

                @Override
                public void onScanFailed(int errorCode) {
                    super.onScanFailed(errorCode);
                }
            });
        }
    }

    @Nullable
    @RequiresApi(21 /* Build.VERSION_CODES.LOLLIPOP */)
    public List<android.bluetooth.le.ScanFilter> toNativeFilters(ScanFilter... scanFilters) {
        final boolean isFilteringDefined = scanFilters != null && scanFilters.length > 0;
        final List<android.bluetooth.le.ScanFilter> returnList;
        if (isFilteringDefined) {
            returnList = new ArrayList<>(scanFilters.length);
            for (ScanFilter scanFilter : scanFilters) {
                returnList.add(toNative(scanFilter));
            }
        } else {
            returnList = null;
        }
        return returnList;
    }

    @RequiresApi(21 /* Build.VERSION_CODES.LOLLIPOP */)
    private static android.bluetooth.le.ScanFilter toNative(ScanFilter scanFilter) {
        final android.bluetooth.le.ScanFilter.Builder builder = new android.bluetooth.le.ScanFilter.Builder();
        if (scanFilter.getServiceDataUuid() != null) {
            builder.setServiceData(scanFilter.getServiceDataUuid(), scanFilter.getServiceData(), scanFilter.getServiceDataMask());
        }
        if (scanFilter.getDeviceAddress() != null) {
            builder.setDeviceAddress(scanFilter.getDeviceAddress());
        }
        return builder
                .setDeviceName(scanFilter.getDeviceName())
                .setManufacturerData(scanFilter.getManufacturerId(), scanFilter.getManufacturerData(), scanFilter.getManufacturerDataMask())
                .setServiceUuid(scanFilter.getServiceUuid(), scanFilter.getServiceUuidMask())
                .build();
    }

    private void cleanupScanner(BluetoothLeScanner bluetoothLeScanner) {
        if (bluetoothLeScanner == null) {
            return;
        }
        try {
            Method cleanupMethod = bluetoothLeScanner.getClass().getMethod("cleanup");
            cleanupMethod.invoke(bluetoothLeScanner);
        } catch (Exception e) {
            LogUtils.printE(e.toString());
        }
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
