package com.tecpal.blue.tecpal_blue.constant;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * @author : ShiMing
 * @editor :
 * @description :
 * @created : 2022-03-23 14:55
 */
@Retention(RetentionPolicy.SOURCE)
public @interface BluetoothState {

    String UNKNOWN = "Unknown";
    String RESETTING = "Resetting";
    String UNSUPPORTED = "Unsupported";
    String UNAUTHORIZED = "Unauthorized";
    String POWERED_OFF = "PoweredOff";
    String POWERED_ON = "PoweredOn";
}
