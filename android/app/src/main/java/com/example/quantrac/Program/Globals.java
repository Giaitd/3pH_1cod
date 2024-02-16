package com.example.quantrac.Program;

import com.example.quantrac.COD_BOD_Module.CodBodData;
import com.example.quantrac.DIDOModule.DIData;
import com.example.quantrac.DIDOModule.DOData;
import com.example.quantrac.Nh4module.Nh4Data;
import com.example.quantrac.PHModule.PHData;
import com.example.quantrac.TSSModule.TSSData;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

public class Globals {

    public static Integer idOld = 6;
    public static Integer idNew = 10;
    public static Boolean btnSetId = false;

    //calibration
    public static Boolean pHZero = false;
    public static Boolean pHSlopeLo = false;
    public static Boolean pHSlopeHi = false;

    public static Boolean nh4Zero = false;
    public static Boolean nh4Slope = false;

    public static Boolean tssZero = false;
    public static Boolean tssSlope = false;

    public static Boolean codDefault = false;
    public static Boolean turnOnBrush = false;
    public static double X = 0.2;
    public static double Y = 151.2;
    public static Boolean codCalibration = false;


    // module di-do
    public static DIData dIData = null;
    public static DOData dOData = null;
    public static byte[] bufferAll = null;

    public static PHData getPHData = null;
    public static CodBodData getCodBodData = null;
    public static Nh4Data getNH4Data = null;
    public static TSSData getTssData = null;

    public static Timer timerReadDIDOData;
    public static TimerTask timerReadDIDODataTask;


    //data realtime
    public static Double pH = -0.01;
    public static Double temp = -0.01;
    public static Double cod = -0.01;
    public static Double bod = -0.01;
    public static Double tss = -0.01;
    public static Double nh4 = -0.01;

    //offset data
    public static Double offsetpH = 0.0;
    public static Double offsetCOD = 0.0;
    public static Double offsetNH4 = 0.0;
    public static Double offsetTSS = 0.0;

    //data setup from UI
    public static Double pHMinSet = 6.5;
    public static Double pHMaxSet = 8.5;
    public static Double codSet = 100.0;
    public static Double bodSet = 50.0;
    public static Double tssSet = 100.0;
    public static Double nh4Set = 10.0;

    //FTP server
    public static String FTP_server = "ftp.dlptest.com";
    public static String FTP_username = "dlpuser";
    public static String FTP_password = "rNrKYTX9g7z3RgJRmxWuGHbeu";
    public static int FTP_port = 21;
    public static String FTP_fileName = "/abc.txt";  // chứa đường dẫn + tên file
    public static String FTP_destination=""; // nơi lưu trữ ở FTP server
    public static List<String> fileDuLieuQuanTrac = new ArrayList<>();
    public static String localFilePath = "";
    public static String tenTepDuLieu_1 = "";
    public static String folderStorage = "";
    public static String thoiGian = ""; //yyyyMMdd
    public static File file;



}
