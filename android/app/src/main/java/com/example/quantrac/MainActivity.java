package com.example.quantrac;

import androidx.annotation.NonNull;

import com.example.quantrac.COD_BOD_Module.ReadCodBod;
import com.example.quantrac.DIDOModule.ReadDIDO;
import com.example.quantrac.FTP_method.saveDataToTextFile;
import com.example.quantrac.FTP_method.sentFileToFTPServer;
import com.example.quantrac.Nh4module.ReadNh4;
import com.example.quantrac.PHModule.ReadPH;
import com.example.quantrac.Program.Calibration;
import com.example.quantrac.Program.ControlOutput;
import com.example.quantrac.Program.Globals;
import com.example.quantrac.TSSModule.ReadTSS;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "giaitd.com/data";

    Timer timerControlOutput = new Timer();
    Timer timerGetPH1 = new Timer();
    Timer timerGetCod = new Timer();
    Timer timerGetNH4 = new Timer();
    Timer timerGetTSS = new Timer();
    Timer timerGetDIDO = new Timer();
    Timer timerSetCalibration = new Timer();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
//          timerGetPH1.schedule(ReadPH.getPHTask(getApplicationContext()), 0, 4000);
        //  timerGetCod.schedule(ReadCodBod.getCodBodTask(getApplicationContext()), 100, 4000);
//          timerGetNH4.schedule(ReadNh4.getNH4Task(getApplicationContext()),200,4000);
//          timerGetTSS.schedule(ReadTSS.getTSSTask(getApplicationContext()),300,4000);
//          timerGetDIDO.schedule(ReadDIDO.getDIDOTask(getApplicationContext()), 400, 2000);
//          timerControlOutput.schedule(ControlOutput.controlOutputTask(getApplicationContext()), 500, 2000);
//          timerSetCalibration.schedule(Calibration.CalibrationSensor(getApplicationContext()), 600, 1000);


        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    //TODO

                    final Map<String, Object> arg = call.arguments();
                    final HashMap<String, Object> arg2 = new HashMap<String, Object>();

                    //channel
                    if (call.method.equals("dataToNative")) {

                        Globals.pHMinSet = (double) arg.get("pHMinSet");
                        Globals.pHMaxSet = (double) arg.get("pHMaxSet");
                        Globals.codSet = (double) arg.get("codSet");
                        Globals.bodSet = (double) arg.get("bodSet");
                        Globals.nh4Set = (double) arg.get("nh4Set");
                        Globals.tssSet = (double) arg.get("tssSet");
                        Globals.offsetpH = (double) arg.get("offsetPH");
                        Globals.offsetCOD = (double) arg.get("offsetCOD");
                        Globals.offsetNH4 = (double) arg.get("offsetNH4");
                        Globals.offsetTSS = (double) arg.get("offsetTSS");

                    } else if (call.method.equals("calibrationPH")) {
                        Globals.pHZero = (boolean) arg.get("calibpHZero");
                        Globals.pHSlopeLo = (boolean) arg.get("calibpHSlopeLo");
                        Globals.pHSlopeHi = (boolean) arg.get("calibpHSlopeHi");

                    } else if (call.method.equals("calibrationTSS")) {
                        Globals.tssZero = (boolean) arg.get("calibTSSZero");
                        Globals.tssSlope = (boolean) arg.get("calibTSSSlope");

                    } else if (call.method.equals("calibrationNH4")) {
                        Globals.nh4Zero = (boolean) arg.get("calibNH4Zero");
                        Globals.nh4Slope = (boolean) arg.get("calibNH4Slope");

                    } else if (call.method.equals("calibrationCOD")) {
                        Globals.codDefault = (boolean) arg.get("calibCODDefault");
                        Globals.turnOnBrush = (boolean) arg.get("turnOnBrush");
                        Globals.codCalibration = (boolean) arg.get("calibCODSensor");
                        Globals.X = (double) arg.get("x");
                        Globals.Y = (double) arg.get("y");

                    } else if (call.method.equals("sendDataFileTransferToNative")) {
                        Globals.tenTepDuLieu_1 = (String) arg.get("fileName");
                        Globals.folderStorage = (String) arg.get("folder");
                        Globals.thoiGian = (String) arg.get("thoiGian");
                        Globals.FTP_server = (String) arg.get("ftpServerName");
                        Globals.FTP_username = (String) arg.get("ftpUsername");
                        Globals.FTP_password = (String) arg.get("ftpPassword");
                        Globals.FTP_port = (int) arg.get("ftpPort");

                        saveDataToTextFile.saveDataToTextFile(getApplicationContext());
                        try {
                            Thread.sleep(200);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        sentFileToFTPServer.sendFileToFTPServer(getApplicationContext());
                        try {
                            Thread.sleep(200);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    } else if (call.method.equals("getData")) {
                        arg2.put("getPH", Globals.pH);
                        arg2.put("getTemp", Globals.temp);
                        arg2.put("getCod", Globals.cod);
                        arg2.put("getBod", Globals.bod);
                        arg2.put("getTss", Globals.tss);
                        arg2.put("getNh4", Globals.nh4);


                        result.success(arg2);
                    } else {
                        result.notImplemented();
                    }
                });

    }


}