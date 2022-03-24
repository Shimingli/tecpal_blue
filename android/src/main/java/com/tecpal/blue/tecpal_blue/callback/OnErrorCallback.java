package com.tecpal.blue.tecpal_blue.callback;

import com.tecpal.blue.tecpal_blue.error.BleError;

/**
 * @author : ShiMing
 * @editor :
 * @description :
 * @created : 2022-03-23 12:24
 */
public interface OnErrorCallback {

    void onError(BleError error);
}
