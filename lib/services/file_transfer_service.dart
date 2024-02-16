import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../helper/router.dart';
import '../view/flutter_flow/flutter_flow_util.dart';

class FileTransferService extends GetxService {
  final storage = const FlutterSecureStorage();

  //tên file lưu trữ dữ liệu
  RxString fileName = "HN_HONG_NUOHON".obs;
  RxString folder = "".obs; //D://HaNoi/NuocThai/TramHongPhat/
  RxString thoiGian = "".obs;

  RxString ftpServerName = "ftp.dlptest.com".obs;
  RxString ftpUsername = "dlpuser".obs;
  RxString ftpPassword = "rNrKYTX9g7z3RgJRmxWuGHbeu".obs;
  RxString ftpPort = "21".obs;

  bool tranfered = false;

  // tên file + folder lưu trữ
  Future<void> setDataForTranfer(
      BuildContext context, String nameFile, String folderStorage) async {
    await storage.delete(key: 'fileName', aOptions: _getAndroidOptions());
    await storage.delete(key: 'folderStorage', aOptions: _getAndroidOptions());

    await storage.write(
        key: 'fileName', value: nameFile, aOptions: _getAndroidOptions());
    await storage.write(
        key: 'folderStorage',
        value: folderStorage,
        aOptions: _getAndroidOptions());

    // đọc giá trị vừa lưu
    await getDataFTPStorage();

    EasyLoading.dismiss();
    showNotification(title: 'Thay đổi thông tin thành công');
  }

  // cài đặt ftp server
  Future<void> setFTPServer(BuildContext context, String ftpServerName,
      String ftpUsername, String ftpPassword, String ftpPort) async {
    await storage.delete(key: 'ftpServerName', aOptions: _getAndroidOptions());
    await storage.delete(key: 'ftpUsername', aOptions: _getAndroidOptions());
    await storage.delete(key: 'ftpPassword', aOptions: _getAndroidOptions());
    await storage.delete(key: 'ftpPort', aOptions: _getAndroidOptions());

    await storage.write(
        key: 'ftpServerName',
        value: ftpServerName,
        aOptions: _getAndroidOptions());
    await storage.write(
        key: 'ftpUsername', value: ftpUsername, aOptions: _getAndroidOptions());
    await storage.write(
        key: 'ftpPassword', value: ftpPassword, aOptions: _getAndroidOptions());
    await storage.write(
        key: 'ftpPort', value: ftpPort, aOptions: _getAndroidOptions());

    // đọc giá trị vừa lưu
    await getDataFTPStorage();

    EasyLoading.dismiss();
    showNotification(title: 'Thay đổi thông tin thành công');
  }

  static const platform = MethodChannel('giaitd.com/data');

  Future<void> sendDataFileTransferToNative() async {
    //date-time
    DateTime time = DateTime.now();
    var formatterDate = DateFormat('yyyyMMdd');
    var formatterTime = DateFormat('kkmmss');
    String day = formatterDate.format(time);
    String timeOfDay = formatterTime.format(time);
    thoiGian.value = day + timeOfDay;

    var sendDataFileTransferToNative = <String, dynamic>{
      "fileName": fileName.value,
      "folder": folder.value,
      "thoiGian": thoiGian.value,
      "ftpServerName": ftpServerName.value,
      "ftpUsername": ftpUsername.value,
      "ftpPassword": ftpPassword.value,
      "ftpPort": ftpPort.value,
    };

    try {
      await platform.invokeMethod(
          'sendDataFileTransferToNative', sendDataFileTransferToNative);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> getDataFTPStorage() async {
    String? a =
        await storage.read(key: 'fileName', aOptions: _getAndroidOptions());
    String? b = await storage.read(
        key: 'folderStorage', aOptions: _getAndroidOptions());

    String? c = await storage.read(
        key: 'ftpServerName', aOptions: _getAndroidOptions());
    String? d =
        await storage.read(key: 'ftpUsername', aOptions: _getAndroidOptions());
    String? e =
        await storage.read(key: 'ftpPassword', aOptions: _getAndroidOptions());
    String? f =
        await storage.read(key: 'ftpPort', aOptions: _getAndroidOptions());

    if (a != null && b != null) {
      fileName.value = a;
      folder.value = b;
    }
    if (c != null && d != null && e != null && f != null) {
      ftpServerName.value = c;
      ftpUsername.value = d;
      ftpPassword.value = e;
      ftpPort.value = f;
    }
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> uploadFileToFTPServer() async {
    //1 giờ upload 1 lần vào thời gian phút = 00
    DateTime time = DateTime.now();
    var formatterTime = DateFormat('mm');
    String timeOfDay = formatterTime.format(time);

    if (timeOfDay == "00" && tranfered == false) {
      await getDataFTPStorage();
      await sendDataFileTransferToNative();
      tranfered = true;
    } else if (timeOfDay != "00") {
      tranfered = false;
    }
  }
}
