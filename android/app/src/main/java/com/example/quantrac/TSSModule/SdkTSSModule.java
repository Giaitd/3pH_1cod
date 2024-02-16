package com.example.quantrac.TSSModule;

import android.content.Context;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.example.quantrac.Program.Globals;
import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.IOException;

import asim.sdk.common.Utils;
import asim.sdk.locker.DeviceInfo;


public class SdkTSSModule {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 40;
    public int WRITE_WAIT_MILLIS = 40;
    public static String checkReadTss;
    UsbDeviceConnection usbConnection;

    public SdkTSSModule() {
    }


    public boolean connect(Context context, DeviceInfo deviceInfo, int baudRate) {
        UsbSerialDriver driver = deviceInfo.driver;
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        if (driver.getPorts().size() < deviceInfo.port) {
            Log.d("---sdk-lockerPH---", "connection failed: not enough ports at device");
            return false;
        } else {
            this.usbSerialPort = (UsbSerialPort) driver.getPorts().get(deviceInfo.port);
            usbConnection = usbManager.openDevice(driver.getDevice());
            if (usbConnection == null) {
                if (!usbManager.hasPermission(driver.getDevice())) {
                    Log.d("---sdk-lockerPH---", "connection failed: permission denied");
                } else {
                    Log.d("---sdk-lockerPH---", "connection failed: open failed");
                }
                return false;
            } else {
                try {
                    this.usbSerialPort.open(usbConnection);
                    this.usbSerialPort.setParameters(baudRate, 8, 1, UsbSerialPort.PARITY_NONE);
                    this.connected = true;
                    return true;
                } catch (Exception var8) {
                    Log.d("---sdk-lockerDIDO---", "connection failed: " + var8.getMessage());
                    this.disconnect();
                    return false;
                }
            }
        }
    }

    //read Tss id: 04
    public TSSData getTssData() {
        try {
            byte[] buffer = new byte[]{4, 3, 0, 0, 0, 4, 68, 92}; // 040300000004 445C
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[14];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadTss = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1], bufferStatus[2]});
            if (checkReadTss.equals("040308")) {
                String Tss = Utils.bytesToHex(new byte[]{bufferStatus[3], bufferStatus[4]});
                String temp = Utils.bytesToHex(new byte[]{bufferStatus[7], bufferStatus[8]});
                double TssData = (double) Integer.parseInt(Tss, 16) / 100.0D;
                double tempData = (double) Integer.parseInt(temp, 16) / 10.0D;
                this.disconnect();

                return new TSSData(TssData, tempData);
            } else {
                this.disconnect();
                return null;
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            return null;
        }
    }


    //calibration zero
    public void calibrationZero() {
        try {
            byte[] buffer = new byte[]{4, 6, 16, 0, 0, 0, -115, 95}; //{04,06,10,00,00,00,8D,5F}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //calibration slope
    public void calibrationSlope() {
        try {
            byte[] buffer = new byte[]{4, 6, 16, 4, 39, 16, -42, -94}; //{04,06,10,04,27,10,D6,A2}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }


    public void disconnect() {
        this.connected = false;

        try {
            this.usbSerialPort.close();
        } catch (IOException var2) {
        }

        this.usbSerialPort = null;
    }
}
