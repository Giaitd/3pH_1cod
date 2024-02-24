package com.example.quantrac.COD_BOD_Module;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadCodSensor {

    public static TimerTask getCodSensorTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkCodSensor codSensorSDK = new SdkCodSensor();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);

                    for (DeviceInfo each : devices) {
                        boolean connect = codSensorSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.codSensorData = codSensorSDK.getCodSensorData();
                            if (SdkCodSensor.checkReadCod.equals("010308")) {

                                Globals.bod = Math.round(Globals.codSensorData.bod * 100) / 100.0;
                                Globals.cod = Math.round((Globals.codSensorData.cod + Globals.offsetCOD) * 100) / 100.0;
                                Globals.tss = Math.round(Globals.codSensorData.tss * 100) / 100.0;


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