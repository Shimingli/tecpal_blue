package com.tecpal.blue.tecpal_blue.event;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import com.tecpal.blue.tecpal_blue.LogUtils;

import io.flutter.plugin.common.EventChannel;

/**
 * @NAME: TestStreamHandler
 * @Des:
 * @USER: shiming
 * @DATE: 2022/3/16 14:48
 * @PROJECT_NAME: android
 */
public class TestStreamHandler implements EventChannel.StreamHandler {

    private final Context applicationContext;
    private EventChannel.EventSink eventSink;

    public TestStreamHandler(Context applicationContext) {
        this.applicationContext=applicationContext;

        LogUtils.Sming("TestStreamHandler");
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.eventSink = events;
        final IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        filter.addAction(Intent.ACTION_SCREEN_ON);
        filter.addAction(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
        filter.addAction(Intent.ACTION_USER_PRESENT);
        applicationContext.registerReceiver(mReceiver, filter);
        LogUtils.Sming("onListen");
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
        applicationContext.unregisterReceiver(mReceiver);
        LogUtils.Sming("onCancel");
    }

    private final BroadcastReceiver mReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            LogUtils.Sming("onReceive");
            String action = intent.getAction();
            if (Intent.ACTION_SCREEN_ON.equals(action)) {
                LogUtils.Sming("ACTION_SCREEN_ON");
                eventSink.success("ACTION_SCREEN_ON");
            } else if (Intent.ACTION_SCREEN_OFF.equals(action)) {
                LogUtils.Sming("ACTION_SCREEN_OFF");
                eventSink.success("ACTION_SCREEN_OFF");
            } else if (Intent.ACTION_USER_PRESENT.equals(action)) {
                LogUtils.Sming("ACTION_USER_PRESENT");
                eventSink.success("ACTION_USER_PRESENT");
            } else if (Intent.ACTION_CLOSE_SYSTEM_DIALOGS.equals(intent.getAction())) {
                LogUtils.Sming("ACTION_CLOSE_SYSTEM_DIALOGS");
                eventSink.success("ACTION_CLOSE_SYSTEM_DIALOGS");
            }
        }
    };
}
