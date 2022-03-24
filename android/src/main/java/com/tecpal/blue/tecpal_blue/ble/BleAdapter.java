package com.tecpal.blue.tecpal_blue.ble;


import com.tecpal.blue.tecpal_blue.entity.ScanResultEntity;

import com.tecpal.blue.tecpal_blue.callback.OnErrorCallback;
import com.tecpal.blue.tecpal_blue.callback.OnEventCallback;
import com.tecpal.blue.tecpal_blue.callback.OnSuccessCallback;

/**
 * @NAME: BleAdapter
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/17 17:53
 * @PROJECT_NAME: android
 */
public interface BleAdapter {

    void enable(
            String transactionId,
            OnSuccessCallback<Void> onSuccessCallback,
            OnErrorCallback onErrorCallback);

    void disable(
            String transactionId,
            OnSuccessCallback<Void> onSuccessCallback,
            OnErrorCallback onErrorCallback);

    String getCurrentState();

    void startDeviceScan(
            OnEventCallback<ScanResultEntity> onEventCallback,
            OnErrorCallback onErrorCallback);
}