package com.example.quantrac.Nh4module;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadNh4 {

    public static TimerTask getNH4Task(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkNh4Module phSDK = new SdkNh4Module();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                    for (DeviceInfo each : devices) {
                        boolean connect = phSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.getNH4Data = phSDK.getNH4Data();
                            if (SdkNh4Module.checkReadNH4.equals("030308")) {
                                Globals.nh4 = Math.round((Globals.getNH4Data.nh4 + Globals.offsetNH4) * 100) / 100.0;

                            } else {
                                Globals.nh4 = -1.0;

                            }
                        }
                    }
                });
            }
        };
    }


}