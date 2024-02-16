package com.example.quantrac.Program;

import android.annotation.SuppressLint;
import android.content.Context;

import java.util.Timer;

public class DataRealtime {

    @SuppressLint("HardwareIds")

    public DataRealtime() {
        super();
    }

    public static void initializedTimerTask(Context context) {


        try{
            Globals.timerReadDIDOData = new Timer();
            Globals.timerReadDIDOData.schedule(Globals.timerReadDIDODataTask,0,700);
        }catch (Exception e){
            e.printStackTrace();
        }

    }




}
