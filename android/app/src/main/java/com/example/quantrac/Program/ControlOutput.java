package com.example.quantrac.Program;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;

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
                        try {
                            Globals.pHMid = (Globals.pHMinSet + Globals.pHMaxSet) / 2;

                            if (Globals.dIData.i0[0] && Globals.pH1 > Globals.pHMaxSet) {
                                SetDO.axit1On(context);
                            } else if (Globals.pH1 < (Globals.pHMid + 0.1) || !Globals.dIData.i0[0]) {
                                SetDO.axit1Off(context);
                            }

                            if (Globals.dIData.i0[1] && Globals.pH1 < Globals.pHMinSet) {
                                SetDO.bazo1On(context);
                            } else if (Globals.pH1 > (Globals.pHMid - 0.1) || !Globals.dIData.i0[1]) {
                                SetDO.bazo1Off(context);
                            }

                            //bơm dinh duong, may khuay
                            if (Globals.dIData.i0[2] && Globals.cod < Globals.codSet) {
                                SetDO.stirrerMotorOn(context);
                                if (Globals.delayPump > 0) {
                                    Globals.delayPump--;
                                } else {
                                    SetDO.pumpOn(context);
                                }

                            } else if (!Globals.dIData.i0[2] || Globals.cod > (Globals.codSet + 0.5)) {
                                SetDO.pumpOff(context);
                                SetDO.stirrerMotorOff(context);
                                Globals.delayPump = 30;
                            }
                        } catch (Exception var8) {
                            Log.d("response====", "loi o control output");
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

