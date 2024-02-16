package com.example.quantrac.COD_BOD_Module;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadCodBod {

    public static TimerTask getCodBodTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkCodBodModule codBodSDK = new SdkCodBodModule();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);

                    for (DeviceInfo each : devices) {
                        boolean connect = codBodSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.getCodBodData = codBodSDK.getCodBodData();
                            if (SdkCodBodModule.checkReadCod.equals("080308")) {

//                                Globals.bod = Math.round(Globals.getCodBodData.bod * 100) / 100.0;
                                Globals.cod = Math.round((Globals.getCodBodData.cod + Globals.offsetCOD) * 100) / 100.0;
//                                Globals.tss = Math.round(Globals.getCodBodData.tss * 100) / 100.0;
//                                Globals.tss = 0.0;


                            } else {
                                Globals.bod = -1.0;
                                Globals.cod = -1.0;
                                Globals.tss = -1.0;
                            }
                        }
                    }
                });
            }
        };
    }


}