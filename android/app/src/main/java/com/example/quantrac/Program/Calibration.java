package com.example.quantrac.Program;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.COD_BOD_Module.SdkCodBodModule;
import com.example.quantrac.Nh4module.SdkNh4Module;
import com.example.quantrac.PHModule.SdkPHModule;
import com.example.quantrac.TSSModule.SdkTSSModule;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class Calibration {

    public Calibration() {
        super();
    }

    public static TimerTask CalibrationSensor(Context context) {
        return new TimerTask() {
            Handler mTimerHandler = new Handler();

            public void run() {
                mTimerHandler.post(new Runnable() {
                    @Override
                    public void run() {

                        //calibration pH zero
                        if(Globals.pHZero){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                //    PHSdk.calibrationZero();
                                }
                            }
                        }

                        //calibration pH slope low
                        if(Globals.pHSlopeLo){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                //    PHSdk.calibrationSlopeLow();
                                }
                            }
                        }

                        //calibration pH slope hi
                        if(Globals.pHSlopeHi){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                //    PHSdk.calibrationSlopeHigh();
                                }
                            }
                        }

                        //calibration nh4 zero
                        if(Globals.nh4Zero){
                            SdkNh4Module NH4Sdk = new SdkNh4Module();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = NH4Sdk.connect(context, each, 9600);
                                if (connect) {
                                //    NH4Sdk.calibrationNH4Zero();
                                }
                            }
                        }

                        //calibration nh4 slope
                        if(Globals.nh4Slope){
                            SdkNh4Module NH4Sdk = new SdkNh4Module();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = NH4Sdk.connect(context, each, 9600);
                                if (connect) {
                                //    NH4Sdk.calibrationNH4Slope();
                                }
                            }
                        }

                        //calibration tss zero
                        if(Globals.tssZero){
                            SdkTSSModule TssSdk = new SdkTSSModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = TssSdk.connect(context, each, 9600);
                                if (connect) {
//                                    TssSdk.calibrationZero();
                                }
                            }
                        }

                        //calibration tss slope
                        if(Globals.tssSlope){
                            SdkTSSModule TssSdk = new SdkTSSModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = TssSdk.connect(context, each, 9600);
                                if (connect) {
//                                    TssSdk.calibrationSlope();
                                }
                            }
                        }

                        //calibration cod sensor to default factory
                        if(Globals.codDefault){
                            SdkCodBodModule CODSdk = new SdkCodBodModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                //    CODSdk.calibrationCODDefault();
                                }
                            }
                        }

                        //turn on the brush
                        if(Globals.turnOnBrush){
                            SdkCodBodModule CODSdk = new SdkCodBodModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                    CODSdk.turnOnTheBrush();
                                }
                            }
                        }

                        //calibration code sensor
                        if(Globals.codCalibration){
                            SdkCodBodModule CODSdk = new SdkCodBodModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                //    CODSdk.calibrationCOD();
                                }
                            }
                        }
                    }
                });
            }


        };
    }
}
