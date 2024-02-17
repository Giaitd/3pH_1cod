package com.example.quantrac.PHModule;

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


public class SdkPHModule {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 200;
    public int WRITE_WAIT_MILLIS = 200;
    public static String checkReadPH;
    UsbDeviceConnection usbConnection;

    public SdkPHModule() {
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

    //read pH id: 06
    public PHData getPH1Data() {
        try {
            byte[] buffer = new byte[]{6, 3, 0, 0, 0, 4, 69, -66}; // CRC: 45 BE -> 45 <->69; BE <-> 190, quy đổi ra thành 190-256 = -69
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[14];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadPH = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1], bufferStatus[2]});
            if (checkReadPH.equals("060308")) {
                String pH = Utils.bytesToHex(new byte[]{bufferStatus[3], bufferStatus[4]});
                String temp = Utils.bytesToHex(new byte[]{bufferStatus[7], bufferStatus[8]});
                double PhData = (double) Integer.parseInt(pH, 16) / 100.0D;
                double tempData = (double) Integer.parseInt(temp, 16) / 10.0D;
                this.disconnect();

                return new PHData(PhData, tempData);
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

    //read pH2: id = 7
    public PHData getPH2Data() {
        try {
            byte[] buffer = new byte[]{7, 3, 0, 0, 0, 4, 68, 111};
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[14];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadPH = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1], bufferStatus[2]});
            if (checkReadPH.equals("070308")) {
                String pH = Utils.bytesToHex(new byte[]{bufferStatus[3], bufferStatus[4]});
                String temp = Utils.bytesToHex(new byte[]{bufferStatus[7], bufferStatus[8]});
                double PhData = (double) Integer.parseInt(pH, 16) / 100.0D;
                double tempData = (double) Integer.parseInt(temp, 16) / 10.0D;
                this.disconnect();
                return new PHData(PhData, tempData);
            } else {
                this.disconnect();
                return null;
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            this.disconnect();
            return null;
        }
    }

    //read pH3: id =8
    public PHData getPH3Data() {
        try {
            byte[] buffer = new byte[]{8, 3, 0, 0, 0, 4, 68, -112};
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[14];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadPH = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1], bufferStatus[2]});
            if (checkReadPH.equals("080308")) {
                String pH = Utils.bytesToHex(new byte[]{bufferStatus[3], bufferStatus[4]});
                String temp = Utils.bytesToHex(new byte[]{bufferStatus[7], bufferStatus[8]});
                double PhData = (double) Integer.parseInt(pH, 16) / 100.0D;
                double tempData = (double) Integer.parseInt(temp, 16) / 10.0D;
                this.disconnect();
                return new PHData(PhData, tempData);
            } else {
                this.disconnect();
                return null;
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            this.disconnect();
            return null;
        }
    }


    //set id
    public void setID() {
        try {
            this.usbSerialPort.write(Globals.bufferAll, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }

    }

    //calibration zero
    public void calibration1Zero() {
        try {
            byte[] buffer = new byte[]{6, 6, 16, 0, 0, 0, -116, -67}; //{06,06,10,00,00,00,8C,BD}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //calibration slope 4.01
    public void calibration1SlopeLow() {
        try {
            byte[] buffer = new byte[]{6, 6, 16, 2, 0, 0, 45, 125}; //{06,06,10,02,00,00,2D,7D}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //calibration slope 9.18
    public void calibration1SlopeHigh() {
        try {
            byte[] buffer = new byte[]{6, 6, 16, 4, 0, 0, -51, 124}; //{06,06,10,04,00,00,CD,7C}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //calibration pH2
    public void calibration2Zero() {
        try {
            byte[] buffer = new byte[]{7, 6, 16, 0, 0, 0, -67, 108}; //{07,06,10,00,00,00,8D,6C}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    public void calibration2SlopeLow() {
        try {
            byte[] buffer = new byte[]{7, 6, 16, 2, 0, 0, 44, -84}; //{07,06,10,02,00,00,2C,AC}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    public void calibration2SlopeHigh() {
        try {
            byte[] buffer = new byte[]{7, 6, 16, 4, 0, 0, -52, -83}; //{07,06,10,04,00,00,CC,AD}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //calibration pH3
    public void calibration3Zero() {
        try {
            byte[] buffer = new byte[]{8, 6, 16, 0, 0, 0, -67, -109}; //{08,06,10,00,00,00,8D,93}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    public void calibration3SlopeLow() {
        try {
            byte[] buffer = new byte[]{8, 6, 16, 2, 0, 0, 44, 83}; //{08,06,10,02,00,00,2C,53}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    public void calibration3SlopeHigh() {
        try {
            byte[] buffer = new byte[]{8, 6, 16, 4, 0, 0, -52, 82}; //{09,06,10,04,00,00,CC,52}
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
