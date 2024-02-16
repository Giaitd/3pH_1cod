package com.example.quantrac.DIDOModule;


import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadDIDO {

    public static TimerTask getDIDOTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {
                    SdkDIDOModule DOSdk = new SdkDIDOModule();

                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                    for (DeviceInfo each : devices) {
                        boolean connect = DOSdk.connect(context, each, 9600);
                        if (connect) {
                            Globals.dOData = DOSdk.getDOData();
                        }

                        connect = DOSdk.connect(context, each, 9600);
                        if (connect) {
                            Globals.dIData = DOSdk.getDIData();
                        }
                    }
                });
            }
        };
    }


}


