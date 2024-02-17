package com.example.quantrac.Program;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;

import androidx.annotation.Nullable;

import com.example.quantrac.DIDOModule.SetDO;

import java.util.TimerTask;

public class ControlOutput extends android.app.Service {


    public ControlOutput() {
        super();
    }

    public static TimerTask controlOutputTask(Context context) {
        return new TimerTask() {
            Handler mTimerHandler = new Handler();

            public void run() {
                mTimerHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        if (Globals.pH1 < Globals.pHMinSet || Globals.pH1 > Globals.pHMaxSet) {
                            SetDO.pumpOn(context);
                        } else if (Globals.pH1 > (Globals.pHMinSet + 0.05) && Globals.pH1 < (Globals.pHMaxSet - 0.05)) {
                            SetDO.pumpOff(context);
                        }
                    }
                });
            }
        };
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}

