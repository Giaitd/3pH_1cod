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

    public static byte[] bufferQ02On = {2, 5, 0, 2, -1, 0, 45, -55};    //bơm axit2 on
    public static byte[] bufferQ02Off = {2, 5, 0, 2, 0, 0, 108, 57};   //bơm axit2 off

    public static byte[] bufferQ03On = {2, 5, 0, 3, -1, 0, 124, 9};   //bơm bazo2 on
    public static byte[] bufferQ03Off = {2, 5, 0, 3, 0, 0, 61, -7};   //bơm bazo2 off

    public static byte[] bufferQ04On = {2, 5, 0, 4, -1, 0, -51, -56};   //bơm axit3 on
    public static byte[] bufferQ04Off = {2, 5, 0, 4, 0, 0, -116, 56};   //bơm axit3 off

    public static byte[] bufferQ05On = {2, 5, 0, 5, -1, 0, -100, 8};   //bơm bazo3 on
    public static byte[] bufferQ05Off = {2, 5, 0, 5, 0, 0, -35, -8};   //bơm bazo3 off

    public static byte[] bufferQ06On = {2, 5, 0, 6, -1, 0, 108, 8};   //bơm axit4 on
    public static byte[] bufferQ06Off = {2, 5, 0, 6, 0, 0, 45, -8};   //bơm axit4 off

    public static byte[] bufferQ07On = {2, 5, 0, 7, -1, 0, 61, -56};   //bơm bazo4 on
    public static byte[] bufferQ07Off = {2, 5, 0, 7, 0, 0, 124, 56};   //bơm bazo4 off

    public static byte[] bufferQ10On = {2, 5, 0, 8, -1, 0, 13, -53};  //bơm axit5 on
    public static byte[] bufferQ10Off = {2, 5, 0, 8, 0, 0, 76, 59};  //bơm axit5 off

    public static byte[] bufferQ11On = {2, 5, 0, 9, -1, 0, 92, 11};   //bơm bazo5 on
    public static byte[] bufferQ11Off = {2, 5, 0, 9, 0, 0, 29, -5};  //bơm bazo5 off

    public static byte[] bufferQ12On = {2, 5, 0, 10, -1, 0, -84, 11};    //bơm axit6 on
    public static byte[] bufferQ12Off = {2, 5, 0, 10, 0, 0, -19, -5};   //bơm axit6 off

    public static byte[] bufferQ13On = {2, 5, 0, 11, -1, 0, -3, -53};   //bơm bazo6 on
    public static byte[] bufferQ13Off = {2, 5, 0, 11, 0, 0, -68, 59};   //bơm bazo6 off

    public static byte[] bufferQ14On = {2, 5, 0, 12, -1, 0, 76, 10};   //bơm axit7 on
    public static byte[] bufferQ14Off = {2, 5, 0, 12, 0, 0, 13, -6};   //bơm axit7 off

    public static byte[] bufferQ15On = {2, 5, 0, 13, -1, 0, 29, -54};   //bơm bazo7 on
    public static byte[] bufferQ15Off = {2, 5, 0, 13, 0, 0, 92, 58};   //bơm bazo7 off

    public static byte[] bufferQ16On = {2, 5, 0, 14, -1, 0, -19, -54};   //bơm axit8 on
    public static byte[] bufferQ16Off = {2, 5, 0, 14, 0, 0, -84, 58};   //bơm axit8 off

    public static byte[] bufferQ17On = {2, 5, 0, 15, -1, 0, -68, 10};   //bơm bazo8 on
    public static byte[] bufferQ17Off = {2, 5, 0, 15, 0, 0, -3, -6};   //bơm bazo8 off


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

    //Bơm quan trắc On/Off
    public static void pumpOn(Context context) {
        if (!Globals.dOData.q0[0]) {
            Globals.bufferAll = bufferQ00On;
            writeDO(context);
        }
    }

    public static void pumpOff(Context context) {
        if (Globals.dOData.q0[0]) {
            Globals.bufferAll = bufferQ00Off;
            writeDO(context);
        }
    }

    //bazo1 on/off
    public static void bazo1On(Context context) {
        Globals.bufferAll = bufferQ01On;
        writeDO(context);
    }

    public static void bazo1Off(Context context) {
        Globals.bufferAll = bufferQ01Off;
        writeDO(context);
    }

    //axit2 on/off
    public static void axit2On(Context context) {
        Globals.bufferAll = bufferQ02On;
        writeDO(context);
    }

    public static void axit2Off(Context context) {
        Globals.bufferAll = bufferQ02Off;
        writeDO(context);
    }

    //bazo2 on/off
    public static void bazo2On(Context context) {
        Globals.bufferAll = bufferQ03On;
        writeDO(context);
    }

    public static void bazo2Off(Context context) {
        Globals.bufferAll = bufferQ03Off;
        writeDO(context);
    }

    //axit3 on/off
    public static void axit3On(Context context) {
        Globals.bufferAll = bufferQ04On;
        writeDO(context);
    }

    public static void axit3Off(Context context) {
        Globals.bufferAll = bufferQ04Off;
        writeDO(context);
    }

    //bazo3 on/off
    public static void bazo3On(Context context) {
        Globals.bufferAll = bufferQ05On;
        writeDO(context);
    }

    public static void bazo3Off(Context context) {
        Globals.bufferAll = bufferQ05Off;
        writeDO(context);
    }

    //axit4 on/off
    public static void axit4On(Context context) {
        Globals.bufferAll = bufferQ06On;
        writeDO(context);
    }

    public static void axit4Off(Context context) {
        Globals.bufferAll = bufferQ06Off;
        writeDO(context);
    }

    //bazo4 on/off
    public static void bazo4On(Context context) {
        Globals.bufferAll = bufferQ07On;
        writeDO(context);
    }

    public static void bazo4Off(Context context) {
        Globals.bufferAll = bufferQ07Off;
        writeDO(context);
    }

    //axit5 on/off
    public static void axit5On(Context context) {
        Globals.bufferAll = bufferQ10On;
        writeDO(context);
    }

    public static void axit5Off(Context context) {
        Globals.bufferAll = bufferQ10Off;
        writeDO(context);
    }

    //bazo5 on/off
    public static void bazo5On(Context context) {
        Globals.bufferAll = bufferQ11On;
        writeDO(context);
    }

    public static void bazo5Off(Context context) {
        Globals.bufferAll = bufferQ11Off;
        writeDO(context);
    }

    //axit6 on/off
    public static void axit6On(Context context) {
        Globals.bufferAll = bufferQ12On;
        writeDO(context);
    }

    public static void axit6Off(Context context) {
        Globals.bufferAll = bufferQ12Off;
        writeDO(context);
    }

    //bazo6 on/off
    public static void bazo6On(Context context) {
        Globals.bufferAll = bufferQ13On;
        writeDO(context);
    }

    public static void bazo6Off(Context context) {
        Globals.bufferAll = bufferQ13Off;
        writeDO(context);
    }

    //axit7 on/off
    public static void axit7On(Context context) {
        Globals.bufferAll = bufferQ14On;
        writeDO(context);
    }

    public static void axit7Off(Context context) {
        Globals.bufferAll = bufferQ14Off;
        writeDO(context);
    }

    //bazo7 on/off
    public static void bazo7On(Context context) {
        Globals.bufferAll = bufferQ15On;
        writeDO(context);
    }

    public static void bazo7Off(Context context) {
        Globals.bufferAll = bufferQ15Off;
        writeDO(context);
    }

    //axit8 on/off
    public static void axit8On(Context context) {
        Globals.bufferAll = bufferQ16On;
        writeDO(context);
    }

    public static void axit8Off(Context context) {
        Globals.bufferAll = bufferQ16Off;
        writeDO(context);
    }

    //bazo8 on/off
    public static void bazo8On(Context context) {
        Globals.bufferAll = bufferQ17On;
        writeDO(context);
    }

    public static void bazo8Off(Context context) {
        Globals.bufferAll = bufferQ17Off;
        writeDO(context);
    }

}
