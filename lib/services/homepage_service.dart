// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/services/file_transfer_service.dart';

class HomePageService extends GetxService {
  FileTransferService fileTransferService = Get.put(FileTransferService());

  RxDouble sizeDevice = 1.1.obs;

  //check timer sent data to server run
  RxBool check = false.obs;

  //androidbox info (use to this topic name to receive thietBiId)
  RxString androidBoxInfo = '20099002'.obs;

  //thietBiId
  RxString thietBiId = "".obs;

  //list data
  RxList pHDataList = [].obs;
  RxList dataQuanTracList = [].obs;
  RxList<dynamic> listData = [].obs;
  //set id
  RxInt idOld = 6.obs;
  RxInt idNew = 7.obs;
  RxBool setID = false.obs;
  RxBool offSetID = false.obs;
  RxBool lockDevice = true.obs;

  //data setup
  RxDouble pHMinSet = 6.5.obs;
  RxDouble pHMaxSet = 8.5.obs;
  RxDouble codSet = 100.0.obs;
  RxDouble bodSet = 50.0.obs;
  RxDouble tssSet = 50.0.obs;

  //data quan trắc
  RxDouble pH1 = 0.0.obs;
  RxDouble temp1 = 0.0.obs;
  RxDouble cod = 0.0.obs;
  RxDouble bod = 0.0.obs;
  RxDouble tss = 0.0.obs;
  RxDouble pH2 = 0.0.obs;
  RxDouble temp2 = 0.0.obs;
  RxDouble pH3 = 0.0.obs;
  RxDouble temp3 = 0.0.obs;

  //data offset
  RxDouble offsetpH1 = 0.0.obs;
  RxDouble offsetCOD = 0.0.obs;
  RxDouble offsetTSS = 0.0.obs;
  RxDouble offsetpH2 = 0.0.obs;
  RxDouble offsetpH3 = 0.0.obs;

  /// //data save for setup parameter
  Map<String, dynamic> mapSetup = {
    "pHMinSet": "6.5",
    "pHMaxSet": "8.5",
    "codSet": "100.0",
    "bodSet": "50.0",
    "tssSet": "100.0",
    "offsetpH1": "0.0",
    "offsetpH2": "0.0",
    "offsetpH3": "0.0",
    "offsetCOD": "0.0",
    "offsetTSS": "0.0",
    "thietBiId": "64746b0adf7ac34be49ce692",
  }.obs;

  List<String> keySetup = [
    "pHMinSet",
    "pHMaxSet",
    "codSet",
    "bodSet",
    "tssSet",
    "offsetpH1",
    "offsetpH2",
    "offsetpH3",
    "offsetCOD",
    "offsetTSS",
    "thietBiId",
  ].obs;
  // ignore: prefer_typing_uninitialized_variables
  var client;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      await fileTransferService.getDataFTPStorage();
      Timer.periodic(const Duration(milliseconds: 2000), (timer) {
        setDataToNative();
        _getData();
      });

      Timer.periodic(const Duration(seconds: 50), (timer) {
        fileTransferService.uploadFileToFTPServer();
      });
    });
  }

  //get androidBoxInfo
  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
      androidBoxInfo.value = deviceData.androidId!;
    }
  }

  /// ============ MethodChannel=== send/get data to/from native ====================== */

  static const platform = MethodChannel('giaitd.com/data');

  //send data setup to native code
  Future<void> setDataToNative() async {
    var sendDataToNative = <String, dynamic>{
      "pHMinSet": double.parse(mapSetup["pHMinSet"]),
      "pHMaxSet": double.parse(mapSetup["pHMaxSet"]),
      "codSet": double.parse(mapSetup["codSet"]),
      "bodSet": double.parse(mapSetup["bodSet"]),
      "tssSet": double.parse(mapSetup["tssSet"]),
      "offsetPH1": double.parse(mapSetup["offsetpH1"]),
      "offsetPH2": double.parse(mapSetup["offsetpH2"]),
      "offsetPH3": double.parse(mapSetup["offsetpH3"]),
      "offsetCOD": double.parse(mapSetup["offsetCOD"]),
    };

    try {
      await platform.invokeMethod('dataToNative', sendDataToNative);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //get data from native code
  Future<void> _getData() async {
    Map<dynamic, dynamic> getDataValues = {};

    try {
      getDataValues = await platform.invokeMethod('getData');
      pH1.value = getDataValues['getPH1'];
      temp1.value = getDataValues['getTemp1'];
      pH2.value = getDataValues['getPH2'];
      temp2.value = getDataValues['getTemp2'];
      pH3.value = getDataValues['getPH3'];
      temp3.value = getDataValues['getTemp3'];
      cod.value = getDataValues['getCod'];
      bod.value = getDataValues['getBod'];
      tss.value = getDataValues['getTss'];
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
