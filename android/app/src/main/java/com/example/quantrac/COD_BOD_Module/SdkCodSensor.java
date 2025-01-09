package com.example.quantrac.COD_BOD_Module;

import android.content.Context;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.example.quantrac.Program.Globals;
import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.IOException;
import java.math.BigInteger;
import java.util.Arrays;

import asim.sdk.common.Utils;
import asim.sdk.locker.DeviceInfo;


public class SdkCodSensor {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 1500;
    public int WRITE_WAIT_MILLIS = 1500;
    public static String checkReadCod, checkReadBod, checkReadTss;
    UsbDeviceConnection usbConnection;

    //calibration cod
    public static double K, B, number;
    public static String codeValue;
    public static byte[] newByte, byteFinal;
    public static int crcHi, crcLow;

    public SdkCodSensor() {
    }

    public boolean connect(Context context, DeviceInfo deviceInfo, int baudRate) {
        UsbSerialDriver driver = deviceInfo.driver;
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        if (driver.getPorts().size() < deviceInfo.port) {
            Log.d("---sdk-lockerCOD---", "connection failed: not enough ports at device");
            return false;
        } else {
            this.usbSerialPort = (UsbSerialPort) driver.getPorts().get(deviceInfo.port);
            usbConnection = usbManager.openDevice(driver.getDevice());
            if (usbConnection == null) {
                if (!usbManager.hasPermission(driver.getDevice())) {
                    Log.d("---sdk-lockerCOD---", "connection failed: permission denied");
                } else {
                    Log.d("---sdk-lockerCOD---", "connection failed: open failed");
                }
                return false;
            } else {
                try {
                    this.usbSerialPort.open(usbConnection);
                    this.usbSerialPort.setParameters(baudRate, 8, 1, UsbSerialPort.PARITY_NONE);
                    this.connected = true;
                    return true;
                } catch (Exception var8) {
                    Log.d("---sdk-lockerCOD---", "connection failed: " + var8.getMessage());
                    this.disconnect();
                    return false;
                }
            }
        }
    }

    //read COD id: 01
    public CodSensorData getCodSensorData() {

        try {
            double bodData;
            double codData;
            double tssData;
            //cod
            byte[] bufferCod = new byte[]{1, 3, 0, 2, 0, 4, -27, -55}; // {01 03 00 02 00 04 E5 C9}
            this.usbSerialPort.write(bufferCod, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatusCod = new byte[15];
            this.usbSerialPort.read(bufferStatusCod, this.READ_WAIT_MILLIS);
            checkReadCod = Utils.bytesToHex(new byte[]{bufferStatusCod[0], bufferStatusCod[1], bufferStatusCod[2]});


//            //bod
//            byte[] bufferBod = new byte[]{1, 3, 32, 4, 0, 2, -114, 10}; // {01 03 20 04 00 02 8E 0A}
//            this.usbSerialPort.write(bufferBod, this.WRITE_WAIT_MILLIS);
//            byte[] bufferStatusBod = new byte[11];
//            this.usbSerialPort.read(bufferStatusBod, this.READ_WAIT_MILLIS);
//            checkReadBod = Utils.bytesToHex(new byte[]{bufferStatusBod[0], bufferStatusBod[1], bufferStatusBod[2]});
//
//
//            //tss
//            byte[] bufferTss = new byte[]{1, 3, 33, 0, 0, 2, -50, 55}; // {01 03 21 00 00 02 CE 37}
//            this.usbSerialPort.write(bufferTss, this.WRITE_WAIT_MILLIS);
//            byte[] bufferStatusTss = new byte[11];
//            this.usbSerialPort.read(bufferStatusTss, this.READ_WAIT_MILLIS);
//            checkReadTss = Utils.bytesToHex(new byte[]{bufferStatusTss[0], bufferStatusTss[1], bufferStatusTss[2]});


            // đọc giá trị COD
            if (checkReadCod.equals("010308") && checkReadBod.equals("010304")) {

                //đọc Cod
                String codString = Utils.bytesToHex(new byte[]{bufferStatusCod[5], bufferStatusCod[6], bufferStatusCod[3], bufferStatusCod[4]});
                String dataReceiveCod = "";
                for (int i = 0; i < codString.length(); i++) {
                    int k = Integer.parseInt(String.valueOf(codString.charAt(i)), 16);
                    dataReceiveCod = dataReceiveCod + String.format("%4s", Integer.toBinaryString(k)).replace(' ', '0');
                }

                String dataReceiveCod0 = String.valueOf(dataReceiveCod.charAt(0));//sign of value: 0: +    1: -
                String dataReceiveCod1 = dataReceiveCod.substring(1, 9);
                String dataReceiveCod2 = dataReceiveCod.substring(9);

                int exponentCod = Integer.parseInt(dataReceiveCod1, 2) - 127;

                String mantissaCod = "";

                String tgCod = "";
                if (exponentCod == -1) {
                    tgCod = "1".concat(dataReceiveCod2);
                    mantissaCod = "0";
                } else if (exponentCod == -2) {
                    tgCod = "01".concat(dataReceiveCod2);
                    mantissaCod = "0";
                } else if (exponentCod < -2) {
                    tgCod = "0";
                    mantissaCod = "0";
                } else {
                    mantissaCod = "1" + dataReceiveCod2.substring(0, exponentCod);
                    tgCod = dataReceiveCod2.substring(exponentCod);
                }
                int numberCod1 = Integer.parseInt(mantissaCod, 2);
                double numberCod2 = 0.0;

                for (int j = 0; j < tgCod.length(); j++) {
                    numberCod2 += Character.getNumericValue(tgCod.charAt(j)) * Math.pow(2, -(j + 1));
                }

                if (dataReceiveCod0.equals("0")) {
                    codData = (numberCod1 + numberCod2);
                } else codData = -(numberCod1 + numberCod2);

                bodData = 0.0;
                tssData = 0.0;


//                //đọc giá trị bod
//                String bodString = Utils.bytesToHex(new byte[]{bufferStatusBod[6], bufferStatusBod[5], bufferStatusBod[4], bufferStatusBod[3]});
//                String dataReceiveBod = "";
//                for (int i = 0; i < bodString.length(); i++) {
//                    int k = Integer.parseInt(String.valueOf(bodString.charAt(i)), 16);
//                    dataReceiveBod = dataReceiveBod + String.format("%4s", Integer.toBinaryString(k)).replace(' ', '0');
//                }
//
//                String dataReceiveBod0 = String.valueOf(dataReceiveBod.charAt(0));//sign of value: 0: +    1: -
//                String dataReceiveBod1 = dataReceiveBod.substring(1, 9);
//                String dataReceiveBod2 = dataReceiveBod.substring(9);
//
//                int exponentBod = Integer.parseInt(dataReceiveBod1, 2) - 127;
//                String mantissaBod = "";
//                String tgBod = "";
//                if (exponentBod == -1) {
//                    tgBod = "1".concat(dataReceiveBod2);
//                    mantissaBod = "0";
//                } else if (exponentBod == -2) {
//                    tgBod = "01".concat(dataReceiveBod2);
//                    mantissaBod = "0";
//                } else if (exponentBod < -2) {
//                    tgBod = "0";
//                    mantissaBod = "0";
//                } else {
//                    mantissaBod = "1" + dataReceiveBod2.substring(0, exponentBod);
//                    tgBod = dataReceiveBod2.substring(exponentBod);
//                }
//                int numberBod1 = Integer.parseInt(mantissaBod, 2);
//                double numberBod2 = 0.0;
//
//                for (int j = 0; j < tgBod.length(); j++) {
//                    numberBod2 += Character.getNumericValue(tgBod.charAt(j)) * Math.pow(2, -(j + 1));
//                }
//
//                if (dataReceiveBod0.equals("0")) {
//                    bodData = numberBod1 + numberBod2;
//                } else bodData = -(numberBod1 + numberBod2);
//
//
//                //đọc giá trị tss ======
//                String tssString = Utils.bytesToHex(new byte[]{bufferStatusTss[6], bufferStatusTss[5], bufferStatusTss[4], bufferStatusTss[3]});
//                if (tssString.equals("00000000")) {
//                    tssData = 0.0;
//                } else {
//                    String dataReceiveTss = "";
//                    for (int i = 0; i < tssString.length(); i++) {
//                        int k = Integer.parseInt(String.valueOf(bodString.charAt(i)), 16);
//                        dataReceiveTss = dataReceiveTss + String.format("%4s", Integer.toBinaryString(k)).replace(' ', '0');
//                    }
//
//                    String dataReceiveTss0 = String.valueOf(dataReceiveTss.charAt(0));//sign of value: 0: +    1: -
//                    String dataReceiveTss1 = dataReceiveTss.substring(1, 9);
//                    String dataReceiveTss2 = dataReceiveTss.substring(9);
//
//                    int exponentTss = Integer.parseInt(dataReceiveTss1, 2) - 127;
//
//                    String mantissaTss = "";
//
//                    String tgTss = "";
//                    if (exponentTss == -1) {
//                        tgTss = "1".concat(dataReceiveTss2);
//                        mantissaTss = "0";
//                    } else if (exponentTss == -2) {
//                        tgTss = "01".concat(dataReceiveTss2);
//                        mantissaTss = "0";
//                    } else if (exponentTss < -2) {
//                        tgTss = "0";
//                        mantissaTss = "0";
//                    } else {
//                        mantissaTss = "1" + dataReceiveTss2.substring(0, exponentTss);
//                        tgTss = dataReceiveTss2.substring(exponentTss);
//                    }
//                    int numberTss1 = Integer.parseInt(mantissaTss, 2);
//                    double numberTss2 = 0.0;
//
//                    for (int j = 0; j < tgTss.length(); j++) {
//                        numberTss2 += Character.getNumericValue(tgTss.charAt(j)) * Math.pow(2, -(j + 1));
//                    }
//
//                    if (dataReceiveTss0.equals("0")) {
//                        tssData = numberTss1 + numberTss2;
//                    } else tssData = -(numberTss1 + numberTss2);
//                }

                this.disconnect();

                return new CodSensorData(codData, bodData, tssData);
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

    //calibration factory default
    public void calibrationCODDefault() {
        try {
            byte[] buffer = new byte[]{1, 16, 34, 0, 0, 4, 8, 0, 0, -128, 63, 0, 0, 0, 0, -59, -99}; //{01,10,22,00,00,04,08,00,00,80,3F,00,00,00,00,C5,9D}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[17];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //turn on the brush
    public void turnOnTheBrush() {
        try {
            byte[] buffer = new byte[]{1, 6, 0, 38, 0, 1, -87, -63}; //{01,06,00,26,00,01,A9,C1}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[9];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //calibration cod sensor
    public void calibrationCOD() {
        try {
            byte[] byteK;
            byte[] byteB;
            byte[] byteFirst = new byte[]{1, 16, 34, 0, 0, 4, 8};
            K = 150 / (Globals.Y * Globals.X);
            B = -(K * Globals.X);
            Log.d("name===K=", String.valueOf(K));
            Log.d("name===B=", String.valueOf(B));

            number = K;
            DecimalToHex();
            byteK = newByte;

            number = B;
            DecimalToHex();
            byteB = newByte;

            //byte lệnh (chưa có CRC)
            byteFinal = new byte[15]; //{01,10,22,00,00,04,08,K1,K2,K3,K4,B1,B2,B3,B4}

            System.arraycopy(byteFirst, 0, byteFinal, 0, byteFirst.length);
            System.arraycopy(byteK, 0, byteFinal, 7, byteK.length);
            System.arraycopy(byteB, 0, byteFinal, 11, byteB.length);

            CalculationCRC();

            //byte cuối cùng (đã có crc)
            byte[] buffer = new byte[17];

            byte[] byteCrcLo = BigInteger.valueOf(crcLow).toByteArray();
            byte[] byteCrcHi = BigInteger.valueOf(crcHi).toByteArray();

            System.arraycopy(byteFinal, 0, buffer, 0, byteFinal.length);
            System.arraycopy(byteCrcLo, 0, buffer, 15, 1);
            System.arraycopy(byteCrcHi, 0, buffer, 16, 1);

            Log.d("name===buffer=", Arrays.toString(buffer));

            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[17];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    public void DecimalToHex() {

        int sign;//bit dấu
        if (number < 0) {
            sign = 1;
        } else sign = 0;

        int number1 = (int) Math.abs(number);
        double number2 = Math.abs(number) - number1;

        //đổi phần nguyên sang kiểu Bin
        String convertToBin1 = Integer.toBinaryString(number1);

        //đổi phần sau dấu phẩy sang bin
        double x = number2;
        String convertToBin2 = "";
        while (x * 2 != 1) {
            if (x * 2 > 1) {
                x = x * 2 - 1;
                convertToBin2 = convertToBin2 + 1;
            } else {
                x = x * 2;
                convertToBin2 = convertToBin2 + 0;
            }
        }
        convertToBin2 = convertToBin2 + 1;

        //tính exponent
        int Exponent = 127 + convertToBin1.substring(1).length();

        String ExponentToString = Integer.toBinaryString(Exponent);

        //dữ liệu sau chuyển đổi
        String totalString = sign + ExponentToString + convertToBin1.substring(1) + convertToBin2;

        //chuyển sang chuỗi đủ 32 bit
        String String32bit = totalString;
        if (totalString.length() < 32) {
            for (int i = 0; i < 32 - totalString.length(); i++) {
                String32bit = String32bit + 0;
            }
        } else if (totalString.length() > 32) {
            String32bit = String32bit.substring(0, 32);
        }

        //chuyển chuỗi 32bit sang kiểu hex
        int TG;
        String hexString = "", a;

        for (int i = 1; i < 9; i++) {
            a = String32bit.substring(i * 4 - 4, i * 4);
            TG = Integer.parseInt(a, 2);
            hexString = hexString + Integer.toString(TG, 16);
        }
        Log.d("name===hexValue===", hexString);

        //Đảo ngược chuỗi hex trên để ghi giá trị vào cảm biến
        codeValue = "";
        for (int i = 0; i < 4; i++) {
            codeValue = codeValue + hexString.substring(6 - i * 2, 8 - i * 2);
        }
//        Log.d("name===codeHexValue===", codeValue);

        //tính toán để đổi byte[hex] sang byte[int] để ghi vào code native
        newByte = new byte[4];
        byte[] byte1;
        String m;
        int k;
        for (int i = 0; i < 4; i++) {
            m = codeValue.substring(i * 2, i * 2 + 2);
            k = Integer.parseInt(m, 16);
            if (k > 127) k = k - 256;
            byte1 = BigInteger.valueOf(k).toByteArray();
            System.arraycopy(byte1, 0, newByte, i, 1);
        }
        Log.d("name===newByte=", Arrays.toString(newByte));
    }

    public void CalculationCRC() {
        int[] table = {
                0x0000, 0xC0C1, 0xC181, 0x0140, 0xC301, 0x03C0, 0x0280, 0xC241,
                0xC601, 0x06C0, 0x0780, 0xC741, 0x0500, 0xC5C1, 0xC481, 0x0440,
                0xCC01, 0x0CC0, 0x0D80, 0xCD41, 0x0F00, 0xCFC1, 0xCE81, 0x0E40,
                0x0A00, 0xCAC1, 0xCB81, 0x0B40, 0xC901, 0x09C0, 0x0880, 0xC841,
                0xD801, 0x18C0, 0x1980, 0xD941, 0x1B00, 0xDBC1, 0xDA81, 0x1A40,
                0x1E00, 0xDEC1, 0xDF81, 0x1F40, 0xDD01, 0x1DC0, 0x1C80, 0xDC41,
                0x1400, 0xD4C1, 0xD581, 0x1540, 0xD701, 0x17C0, 0x1680, 0xD641,
                0xD201, 0x12C0, 0x1380, 0xD341, 0x1100, 0xD1C1, 0xD081, 0x1040,
                0xF001, 0x30C0, 0x3180, 0xF141, 0x3300, 0xF3C1, 0xF281, 0x3240,
                0x3600, 0xF6C1, 0xF781, 0x3740, 0xF501, 0x35C0, 0x3480, 0xF441,
                0x3C00, 0xFCC1, 0xFD81, 0x3D40, 0xFF01, 0x3FC0, 0x3E80, 0xFE41,
                0xFA01, 0x3AC0, 0x3B80, 0xFB41, 0x3900, 0xF9C1, 0xF881, 0x3840,
                0x2800, 0xE8C1, 0xE981, 0x2940, 0xEB01, 0x2BC0, 0x2A80, 0xEA41,
                0xEE01, 0x2EC0, 0x2F80, 0xEF41, 0x2D00, 0xEDC1, 0xEC81, 0x2C40,
                0xE401, 0x24C0, 0x2580, 0xE541, 0x2700, 0xE7C1, 0xE681, 0x2640,
                0x2200, 0xE2C1, 0xE381, 0x2340, 0xE101, 0x21C0, 0x2080, 0xE041,
                0xA001, 0x60C0, 0x6180, 0xA141, 0x6300, 0xA3C1, 0xA281, 0x6240,
                0x6600, 0xA6C1, 0xA781, 0x6740, 0xA501, 0x65C0, 0x6480, 0xA441,
                0x6C00, 0xACC1, 0xAD81, 0x6D40, 0xAF01, 0x6FC0, 0x6E80, 0xAE41,
                0xAA01, 0x6AC0, 0x6B80, 0xAB41, 0x6900, 0xA9C1, 0xA881, 0x6840,
                0x7800, 0xB8C1, 0xB981, 0x7940, 0xBB01, 0x7BC0, 0x7A80, 0xBA41,
                0xBE01, 0x7EC0, 0x7F80, 0xBF41, 0x7D00, 0xBDC1, 0xBC81, 0x7C40,
                0xB401, 0x74C0, 0x7580, 0xB541, 0x7700, 0xB7C1, 0xB681, 0x7640,
                0x7200, 0xB2C1, 0xB381, 0x7340, 0xB101, 0x71C0, 0x7080, 0xB041,
                0x5000, 0x90C1, 0x9181, 0x5140, 0x9301, 0x53C0, 0x5280, 0x9241,
                0x9601, 0x56C0, 0x5780, 0x9741, 0x5500, 0x95C1, 0x9481, 0x5440,
                0x9C01, 0x5CC0, 0x5D80, 0x9D41, 0x5F00, 0x9FC1, 0x9E81, 0x5E40,
                0x5A00, 0x9AC1, 0x9B81, 0x5B40, 0x9901, 0x59C0, 0x5880, 0x9841,
                0x8801, 0x48C0, 0x4980, 0x8941, 0x4B00, 0x8BC1, 0x8A81, 0x4A40,
                0x4E00, 0x8EC1, 0x8F81, 0x4F40, 0x8D01, 0x4DC0, 0x4C80, 0x8C41,
                0x4400, 0x84C1, 0x8581, 0x4540, 0x8701, 0x47C0, 0x4680, 0x8641,
                0x8201, 0x42C0, 0x4380, 0x8341, 0x4100, 0x81C1, 0x8081, 0x4040,
        };
        //tính crc
        int crc = 0xffff;
        for (byte b : byteFinal) {
            crc = (crc >>> 8) ^ table[(crc ^ b) & 0xff];
        }
        String crcHex = Integer.toHexString(crc);
        String checkSum = null;
        if (crcHex.length() == 2) {
            checkSum = "00" + crcHex;
        } else if (crcHex.length() == 3) {
            checkSum = "0" + crcHex;
        } else if (crcHex.length() == 4) {
            checkSum = crcHex;
        }
        String hi = checkSum.substring(0, 2);
        String low = checkSum.substring(2, 4);

        //convert crc from hex to int

        int a = Integer.parseInt(hi, 16);
        int b = Integer.parseInt(low, 16);
        if (a > 127) {
            crcHi = a - 256;
        } else crcHi = a;

        if (b > 127) {
            crcLow = b - 256;
        } else crcLow = b;

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
