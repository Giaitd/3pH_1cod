package com.example.quantrac.Nh4module;

import android.content.Context;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.IOException;

import asim.sdk.common.Utils;
import asim.sdk.locker.DeviceInfo;


public class SdkNh4Module {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 40;
    public int WRITE_WAIT_MILLIS = 40;
    public static String checkReadNH4;
    UsbDeviceConnection usbConnection;

    public SdkNh4Module() {
    }


    public boolean connect(Context context, DeviceInfo deviceInfo, int baudRate) {
        UsbSerialDriver driver = deviceInfo.driver;
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        if (driver.getPorts().size() < deviceInfo.port) {
            Log.d("---sdk-lockerNH4---", "connection failed: not enough ports at device");
            return false;
        } else {
            this.usbSerialPort = (UsbSerialPort) driver.getPorts().get(deviceInfo.port);
            usbConnection = usbManager.openDevice(driver.getDevice());
            if (usbConnection == null) {
                if (!usbManager.hasPermission(driver.getDevice())) {
                    Log.d("---sdk-lockerNH4---", "connection failed: permission denied");
                } else {
                    Log.d("---sdk-lockerNH4---", "connection failed: open failed");
                }
                return false;
            } else {
                try {
                    this.usbSerialPort.open(usbConnection);
                    this.usbSerialPort.setParameters(baudRate, 8, 1, UsbSerialPort.PARITY_NONE);
                    this.connected = true;
                    return true;
                } catch (Exception var8) {
                    Log.d("---sdk-lockerNH4---", "connection failed: " + var8.getMessage());
                    this.disconnect();
                    return false;
                }
            }
        }
    }

    //read NH4 id: 03
    public Nh4Data getNH4Data() {
        try {
            byte[] buffer = new byte[]{3, 3, 0, 0, 0, 4, 69, -21}; //{03 03 00 00 00 04 45 EB}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[14];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadNH4 = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1], bufferStatus[2]});
            if (checkReadNH4.equals("030308")) {
                String nh4String = Utils.bytesToHex(new byte[]{bufferStatus[3], bufferStatus[4]});
                String tempNh4String = Utils.bytesToHex(new byte[]{bufferStatus[7], bufferStatus[8]});
                double NH4Data = (double) Integer.parseInt(nh4String, 16) / 100.0D;
                double tempNH4Data = (double) Integer.parseInt(tempNh4String, 16) / 10.0D;
                this.disconnect();

                return new Nh4Data(NH4Data, tempNH4Data);
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
    public void calibrationNH4Zero() {
        try {
            byte[] buffer = new byte[]{3, 6, 16, 0, 0, 100, -115, 03}; //{03,06,10,00,00,64,8D,03}
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
    public void calibrationNH4Slope() {
        try {
            byte[] buffer = new byte[]{3, 6, 16, 4, 3, -24, -51, -105}; //{03,06,10,04,03,E8,CD,97}
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
