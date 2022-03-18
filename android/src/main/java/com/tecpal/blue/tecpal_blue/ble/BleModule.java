package com.tecpal.blue.tecpal_blue.ble;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.os.Build;

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

}
