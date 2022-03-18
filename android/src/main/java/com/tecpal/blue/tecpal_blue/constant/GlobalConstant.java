package com.tecpal.blue.tecpal_blue.constant;

/**
 * @NAME: GlobalConstant
 * @Des:
 * @USER: ShiMing.li
 * @DATE: 2022/3/16 16:26
 * @PROJECT_NAME: android
 */
public final class GlobalConstant {

    public final class ChannelName {
        public static final String FLUTTER_BLE_LIB = "tecpal_blue";
        public static final String FLUTTER_BLE_LIB_TEST = FLUTTER_BLE_LIB + "/test";


    }

    public final class MethodName {
        public static final String LOG_SMING = "log_sming";

        public static final String IS_CLIENT_CREATED = "isClientCreated";
        public static final String CREATE_CLIENT = "createClient";
        public static final String DESTROY_CLIENT = "destroyClient";

        public static final String CANCEL_TRANSACTION = "cancelTransaction";
        public static final
        String GET_STATE = "getState";

        public static final String ENABLE_RADIO = "enableRadio";
        public static final String DISABLE_RADIO = "disableRadio";

        public static final String START_DEVICE_SCAN = "startDeviceScan";
        public static final String STOP_DEVICE_SCAN = "stopDeviceScan";

        public static final String CONNECT_TO_DEVICE = "connectToDevice";
        public static final String IS_DEVICE_CONNECTED = "isDeviceConnected";
        public static final String OBSERVE_CONNECTION_STATE = "observeConnectionState";
        public static final String CANCEL_CONNECTION = "cancelConnection";

        public static final String DISCOVER_ALL_SERVICES_AND_CHARACTERISTICS = "discoverAllServicesAndCharacteristics";
        public static final String GET_SERVICES = "services";
        public static final String GET_CHARACTERISTICS = "characteristics";
        public static final String GET_CHARACTERISTICS_FOR_SERVICE = "characteristicsForService";
        public static final String GET_DESCRIPTORS_FOR_DEVICE = "descriptorsForDevice";
        public static final String GET_DESCRIPTORS_FOR_CHARACTERISTIC = "descriptorsForCharacteristic";
        public static final String GET_DESCRIPTORS_FOR_SERVICE = "descriptorsForService";

        public static final String LOG_LEVEL = "logLevel";
        public static final String SET_LOG_LEVEL = "setLogLevel";

        public static final String RSSI = "rssi";

        public static final String REQUEST_MTU = "requestMtu";

        public static final String GET_CONNECTED_DEVICES = "getConnectedDevices";
        public static final String GET_KNOWN_DEVICES = "getKnownDevices";

        public static final String READ_CHARACTERISTIC_FOR_IDENTIFIER = "readCharacteristicForIdentifier";
        public static final String READ_CHARACTERISTIC_FOR_DEVICE = "readCharacteristicForDevice";
        public static final String READ_CHARACTERISTIC_FOR_SERVICE = "readCharacteristicForService";

        public static final String WRITE_CHARACTERISTIC_FOR_IDENTIFIER = "writeCharacteristicForIdentifier";
        public static final String WRITE_CHARACTERISTIC_FOR_DEVICE = "writeCharacteristicForDevice";
        public static final String WRITE_CHARACTERISTIC_FOR_SERVICE = "writeCharacteristicForService";

        public static final String MONITOR_CHARACTERISTIC_FOR_IDENTIFIER = "monitorCharacteristicForIdentifier";
        public static final String MONITOR_CHARACTERISTIC_FOR_DEVICE = "monitorCharacteristicForDevice";
        public static final String MONITOR_CHARACTERISTIC_FOR_SERVICE = "monitorCharacteristicForService";

        public static final String READ_DESCRIPTOR_FOR_IDENTIFIER = "readDescriptorForIdentifier";
        public static final String READ_DESCRIPTOR_FOR_CHARACTERISTIC = "readDescriptorForCharacteristic";
        public static final String READ_DESCRIPTOR_FOR_SERVICE = "readDescriptorForService";
        public static final String READ_DESCRIPTOR_FOR_DEVICE = "readDescriptorForDevice";

        public static final String WRITE_DESCRIPTOR_FOR_IDENTIFIER = "writeDescriptorForIdentifier";
        public static final String WRITE_DESCRIPTOR_FOR_CHARACTERISTIC = "writeDescriptorForCharacteristic";
        public static final String WRITE_DESCRIPTOR_FOR_SERVICE = "writeDescriptorForService";
        public static final String WRITE_DESCRIPTOR_FOR_DEVICE = "writeDescriptorForDevice";
    }

}
