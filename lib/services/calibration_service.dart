import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CalibrationService extends GetxService {
  //calibration
  RxBool calibpHZero = false.obs;
  RxBool calibpHSlopeLo = false.obs;
  RxBool calibpHSlopeHi = false.obs;

  RxBool calibNH4Zero = false.obs;
  RxBool calibNH4Slope = false.obs;

  RxBool calibTSSZero = false.obs;
  RxBool calibTSSSlope = false.obs;

  RxBool calibCODDefault = false.obs;
  RxBool turnOnBrush = false.obs;
  RxBool calibCODSensor = false.obs;
  RxDouble X = 0.2.obs;
  RxDouble Y = 151.3.obs;

  static const platform = MethodChannel('giaitd.com/data');

  //hiệu chuẩn đầu đo PH
  Future<void> calibrationPH() async {
    var sendDataToNative1 = <String, dynamic>{
      "calibpHZero": calibpHZero.value,
      "calibpHSlopeLo": calibpHSlopeLo.value,
      "calibpHSlopeHi": calibpHSlopeHi.value,
    };

    try {
      await platform.invokeMethod('calibrationPH', sendDataToNative1);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo NH4
  Future<void> calibrationNH4() async {
    var sendDataToNative2 = <String, dynamic>{
      "calibNH4Zero": calibNH4Zero.value,
      "calibNH4Slope": calibNH4Slope.value,
    };

    try {
      await platform.invokeMethod('calibrationNH4', sendDataToNative2);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo NH4
  Future<void> calibrationTSS() async {
    var sendDataToNative2 = <String, dynamic>{
      "calibTSSZero": calibTSSZero.value,
      "calibTSSSlope": calibTSSSlope.value,
    };

    try {
      await platform.invokeMethod('calibrationTSS', sendDataToNative2);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo COD
  Future<void> calibrationCOD() async {
    var sendDataToNative3 = <String, dynamic>{
      "calibCODDefault": calibCODDefault.value,
      "turnOnBrush": turnOnBrush.value,
      "calibCODSensor": calibCODSensor.value,
      "x": X.value,
      "y": Y.value,
    };

    try {
      await platform.invokeMethod('calibrationCOD', sendDataToNative3);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
