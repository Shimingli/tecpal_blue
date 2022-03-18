package com.tecpal.blue.tecpal_blue.ble;

import android.content.Context;

/**
 * @NAME: BleAdapterCreator
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/17 17:53
 * @PROJECT_NAME: android
 */
public interface BleAdapterCreator {
    BleAdapter createAdapter(Context context);
}
