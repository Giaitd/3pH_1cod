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

                    SdkPHModule pHSDK = new SdkPHModule();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                    for (DeviceInfo each : devices) {
                        boolean connect = pHSDK.connect(context, each, 9600);
                        if (connect) {
                            Globals.getPH1Data = pHSDK.getPH1Data();
                            if (SdkPHModule.checkReadPH.equals("060308")) {
                                Globals.pH1 = Math.round((Globals.getPH1Data.pH + Globals.offsetPH1) * 100) / 100.0;
                                Globals.temp1 = Globals.getPH1Data.temp;
                            } else {
                                Globals.pH1 = 0.00;
                                Globals.temp1 = 0.0;
                            }
                        }

                        connect = pHSDK.connect(context, each, 9600);
                        if (connect) {
                            Globals.getPH2Data = pHSDK.getPH2Data();
                            if (SdkPHModule.checkReadPH.equals("070308")) {
                                Globals.pH2 = Math.round((Globals.getPH2Data.pH + Globals.offsetPH2) * 100) / 100.0;
                                Globals.temp2 = Globals.getPH2Data.temp;
                            } else {
                                Globals.pH2 = 0.00;
                                Globals.temp2 = 0.0;
                            }
                        }

                        connect = pHSDK.connect(context, each, 9600);
                        if (connect) {
                            Globals.getPH3Data = pHSDK.getPH3Data();
                            if (SdkPHModule.checkReadPH.equals("080308")) {
                                Globals.pH3 = Math.round((Globals.getPH3Data.pH + Globals.offsetPH3) * 100) / 100.0;
                                Globals.temp3 = Globals.getPH3Data.temp;
                            } else {
                                Globals.pH3 = 0.00;
                                Globals.temp3 = 0.0;
                            }
                        }
                    }
                });
            }
        };
    }


}