package com.tecpal.blue.tecpal_blue.ble;

import android.content.Context;

/**
 * @NAME: BleAdapterFactory
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/17 17:52
 * @PROJECT_NAME: android
 */
public class BleAdapterFactory {

    private static BleAdapterCreator bleAdapterCreator = new BleAdapterCreator() {
        @Override
        public BleAdapter createAdapter(Context context) {
            return new BleModule(context);
        }
    };

    public static BleAdapter getNewAdapter(Context context) {
        return bleAdapterCreator.createAdapter(context);
    }

    public static void setBleAdapterCreator(BleAdapterCreator bleAdapterCreator) {
        BleAdapterFactory.bleAdapterCreator = bleAdapterCreator;
    }
}

