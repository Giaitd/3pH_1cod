package com.example.quantrac.PHModule;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadPH {

    public static TimerTask getPHTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkPHModule phSDK = new SdkPHModule();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                    for (DeviceInfo each : devices) {
                        boolean connect = phSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.getPHData = phSDK.getPHData();
                            if (SdkPHModule.checkReadPH.equals("060308")) {
                                Globals.pH = Math.round((Globals.getPHData.pH + Globals.offsetpH) * 100) / 100.0;
                                Globals.temp = Globals.getPHData.temp;
                            } else {
                                Globals.pH = 0.00;
                                Globals.temp = 0.0;
                            }
                        }
                    }
                });
            }
        };
    }


}