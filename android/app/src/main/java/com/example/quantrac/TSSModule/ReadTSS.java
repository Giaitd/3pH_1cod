package com.example.quantrac.TSSModule;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadTSS {

    public static TimerTask getTSSTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkTSSModule tssSDK = new SdkTSSModule();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                    for (DeviceInfo each : devices) {
                        boolean connect = tssSDK.connect(context, each, 9600);
                        if (connect) {
                            Globals.getTssData = tssSDK.getTssData();
                            if (SdkTSSModule.checkReadTss.equals("040308")) {
                                Globals.tss = Math.round((Globals.getTssData.Tss + Globals.offsetTSS) * 100) / 100.0;
                            } else {
                                Globals.pH = 0.00;
                            }
                        }
                    }
                });
            }
        };
    }


}