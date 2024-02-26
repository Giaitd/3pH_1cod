package com.example.quantrac.DIDOModule;

import android.content.Context;

import com.example.quantrac.Program.Globals;

import java.util.List;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class SetDO {
    public static byte[] bufferQ00On = {2, 5, 0, 0, -1, 0, -116, 9};  //bơm axit1 on
    public static byte[] bufferQ00Off = {2, 5, 0, 0, 0, 0, -51, -7};  //bơm axit1 off

    public static byte[] bufferQ01On = {2, 5, 0, 1, -1, 0, -35, -55};   //bơm bazo1 on
    public static byte[] bufferQ01Off = {2, 5, 0, 1, 0, 0, -100, 57};  //bơm bazo1 off

    public static byte[] bufferQ02On = {2, 5, 0, 2, -1, 0, 45, -55};    //bơm dinh duong on/off
    public static byte[] bufferQ02Off = {2, 5, 0, 2, 0, 0, 108, 57};

    public static byte[] bufferQ03On = {2, 5, 0, 3, -1, 0, 124, 9};     //động cơ khuấy dinh dưỡng
    public static byte[] bufferQ03Off = {2, 5, 0, 3, 0, 0, 61, -7};

    public static byte[] bufferQ04On = {2, 5, 0, 4, -1, 0, -51, -56};
    public static byte[] bufferQ04Off = {2, 5, 0, 4, 0, 0, -116, 56};

    public static byte[] bufferQ05On = {2, 5, 0, 5, -1, 0, -100, 8};
    public static byte[] bufferQ05Off = {2, 5, 0, 5, 0, 0, -35, -8};

    public static byte[] bufferQ06On = {2, 5, 0, 6, -1, 0, 108, 8};
    public static byte[] bufferQ06Off = {2, 5, 0, 6, 0, 0, 45, -8};

    public static byte[] bufferQ07On = {2, 5, 0, 7, -1, 0, 61, -56};
    public static byte[] bufferQ07Off = {2, 5, 0, 7, 0, 0, 124, 56};

    public static byte[] bufferQ10On = {2, 5, 0, 8, -1, 0, 13, -53};
    public static byte[] bufferQ10Off = {2, 5, 0, 8, 0, 0, 76, 59};

    public static byte[] bufferQ11On = {2, 5, 0, 9, -1, 0, 92, 11};
    public static byte[] bufferQ11Off = {2, 5, 0, 9, 0, 0, 29, -5};

    public static byte[] bufferQ12On = {2, 5, 0, 10, -1, 0, -84, 11};
    public static byte[] bufferQ12Off = {2, 5, 0, 10, 0, 0, -19, -5};

    public static byte[] bufferQ13On = {2, 5, 0, 11, -1, 0, -3, -53};
    public static byte[] bufferQ13Off = {2, 5, 0, 11, 0, 0, -68, 59};

    public static byte[] bufferQ14On = {2, 5, 0, 12, -1, 0, 76, 10};
    public static byte[] bufferQ14Off = {2, 5, 0, 12, 0, 0, 13, -6};

    public static byte[] bufferQ15On = {2, 5, 0, 13, -1, 0, 29, -54};
    public static byte[] bufferQ15Off = {2, 5, 0, 13, 0, 0, 92, 58};

    public static byte[] bufferQ16On = {2, 5, 0, 14, -1, 0, -19, -54};
    public static byte[] bufferQ16Off = {2, 5, 0, 14, 0, 0, -84, 58};

    public static byte[] bufferQ17On = {2, 5, 0, 15, -1, 0, -68, 10};
    public static byte[] bufferQ17Off = {2, 5, 0, 15, 0, 0, -3, -6};


    public static void writeDO(Context context) {

        SdkDIDOModule DOSdk = new SdkDIDOModule();

        List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
        for (DeviceInfo each : devices) {
            boolean connect = DOSdk.connect(context, each, 9600);
            if (connect) {
                if (SdkDIDOModule.checkReadDO.equals("0201")) {
                    DOSdk.setDOData();
                    break;
                }

            }
        }
    }

    //Bơm axit 1 On/Off
    public static void axit1On(Context context) {
        if (!Globals.dOData.q0[0]) {
            Globals.bufferAll = bufferQ00On;
            writeDO(context);
        }
    }

    public static void axit1Off(Context context) {
        if (Globals.dOData.q0[0]) {
            Globals.bufferAll = bufferQ00Off;
            writeDO(context);
        }
    }

    //bazo1 on/off
    public static void bazo1On(Context context) {
        if (!Globals.dOData.q0[1]) {
            Globals.bufferAll = bufferQ01On;
            writeDO(context);
        }
    }

    public static void bazo1Off(Context context) {
        if (Globals.dOData.q0[1]) {
            Globals.bufferAll = bufferQ01Off;
            writeDO(context);
        }
    }

    //bơm dinh duong on/off
    public static void pumpOn(Context context) {
        if (!Globals.dOData.q0[2]) {
            Globals.bufferAll = bufferQ02On;
            writeDO(context);
        }
    }

    public static void pumpOff(Context context) {
        if (Globals.dOData.q0[2]) {
            Globals.bufferAll = bufferQ02Off;
            writeDO(context);
        }
    }

    //may khuay on/off
    public static void stirrerMotorOn(Context context) {
        if (!Globals.dOData.q0[3]) {
            Globals.bufferAll = bufferQ03On;
            writeDO(context);
        }
    }

    public static void stirrerMotorOff(Context context) {
        if (Globals.dOData.q0[3]) {
            Globals.bufferAll = bufferQ03Off;
            writeDO(context);
        }
    }





}
