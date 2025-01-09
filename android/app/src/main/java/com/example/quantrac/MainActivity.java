package com.example.quantrac;

import androidx.annotation.NonNull;

import com.example.quantrac.COD_BOD_Module.ReadCodSensor;
import com.example.quantrac.DIDOModule.ReadDIDO;
import com.example.quantrac.PHModule.ReadPH;
import com.example.quantrac.Program.Calibration;
import com.example.quantrac.Program.ControlOutput;
import com.example.quantrac.Program.Globals;
import com.example.quantrac.Program.SetID;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "giaitd.com/data";

    Timer timerControlOutput = new Timer();
    Timer timerGetPH = new Timer();
    Timer timerGetCod = new Timer();
    Timer timerGetDIDO = new Timer();
    Timer timerSetCalibration = new Timer();
    Timer timerChangeID = new Timer();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
       timerGetPH.schedule(ReadPH.getPHTask(getApplicationContext()), 0, 5000);
       timerGetCod.schedule(ReadCodSensor.getCodSensorTask(getApplicationContext()), 500, 60000);
       timerGetDIDO.schedule(ReadDIDO.getDIDOTask(getApplicationContext()), 600, 2000);
       timerControlOutput.schedule(ControlOutput.controlOutputTask(getApplicationContext()), 700, 2000);
       timerSetCalibration.schedule(Calibration.CalibrationSensor(getApplicationContext()), 800, 1000);
       timerChangeID.schedule(SetID.changeID(getApplicationContext()),1000,1000);


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
                        Globals.tssSet = (double) arg.get("tssSet");
                        Globals.offsetPH1 = (double) arg.get("offsetPH1");
                        Globals.offsetCOD = (double) arg.get("offsetCOD");
                        Globals.offsetTSS = (double) arg.get("offsetTSS");

                    } else if (call.method.equals("calibrationPH1")) {
                        Globals.pH1Zero = (boolean) arg.get("calibpH1Zero");
                        Globals.pH1SlopeLo = (boolean) arg.get("calibpH1SlopeLo");
                        Globals.pH1SlopeHi = (boolean) arg.get("calibpH1SlopeHi");

                    } else if (call.method.equals("calibrationPH2")) {
                        Globals.pH2Zero = (boolean) arg.get("calibpH2Zero");
                        Globals.pH2SlopeLo = (boolean) arg.get("calibpH2SlopeLo");
                        Globals.pH2SlopeHi = (boolean) arg.get("calibpH2SlopeHi");

                    } else if (call.method.equals("calibrationPH3")) {
                        Globals.pH3Zero = (boolean) arg.get("calibpH3Zero");
                        Globals.pH3SlopeLo = (boolean) arg.get("calibpH3SlopeLo");
                        Globals.pH3SlopeHi = (boolean) arg.get("calibpH3SlopeHi");

                    } else if (call.method.equals("calibrationTSS")) {
                        Globals.tssZero = (boolean) arg.get("calibTSSZero");
                        Globals.tssSlope = (boolean) arg.get("calibTSSSlope");

                    } else if (call.method.equals("calibrationCOD")) {
                        Globals.codDefault = (boolean) arg.get("calibCODDefault");
                        Globals.turnOnBrush = (boolean) arg.get("turnOnBrush");
                        Globals.codCalibration = (boolean) arg.get("calibCODSensor");
                        Globals.X = (double) arg.get("x");
                        Globals.Y = (double) arg.get("y");

                    } else if (call.method.equals("getData")) {
                        arg2.put("getPH1", Globals.pH1);
                        arg2.put("getTemp1", Globals.temp1);
                        arg2.put("getPH2", Globals.pH2);
                        arg2.put("getTemp2", Globals.temp2);
                        arg2.put("getPH3", Globals.pH3);
                        arg2.put("getTemp3", Globals.temp3);
                        arg2.put("getCod", Globals.cod);
                        arg2.put("getBod", Globals.bod);
                        arg2.put("getTss", Globals.tss);

                        arg2.put("getDO0", Globals.dOData.valueDO0);
                        arg2.put("getDI0",Globals.dIData.valueDI0);

                        result.success(arg2);
                    } else if (call.method.equals("changeID")) {
                        //id
                        Globals.idOld = (int) arg.get("idOld");
                        Globals.idNew = (int) arg.get("idNew");
                        Globals.btnSetId = (boolean) arg.get("btnSetId");

                    } else {
                        result.notImplemented();
                    }
                });

    }


}