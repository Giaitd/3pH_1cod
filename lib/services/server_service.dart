import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/services/homepage_service.dart';
import 'package:quantrac_online_hongphat/services/mqtt_service.dart';
import 'package:quantrac_online_hongphat/services/request_service.dart';
import 'package:quantrac_online_hongphat/services/url/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../helper/router.dart';
import '../model/duLieuQuanTrac_model.dart';

class ServerService extends GetxService {
  HomePageService homePageService = Get.put(HomePageService());
  RequestService requestService = Get.put(RequestService());
  MqttService mqttService = Get.put(MqttService());
  final storage = const FlutterSecureStorage();

  Future<void> changeServer(BuildContext context, String server, String port,
      String username, String password) async {
    requestService.startRequest(
        title:
            "Thay đổi thông tin server không thành công. Hãy kiểm tra kết nối mạng của thiết bị rồi thử lại");
    //xóa data cũ
    await storage.delete(key: 'server', aOptions: _getAndroidOptions());
    await storage.delete(key: 'port', aOptions: _getAndroidOptions());
    await storage.delete(key: 'username', aOptions: _getAndroidOptions());
    await storage.delete(key: 'password', aOptions: _getAndroidOptions());

    await storage.write(
        key: 'server', value: server, aOptions: _getAndroidOptions());
    await storage.write(
        key: 'port', value: port, aOptions: _getAndroidOptions());
    await storage.write(
        key: 'username', value: username, aOptions: _getAndroidOptions());
    await storage.write(
        key: 'password', value: password, aOptions: _getAndroidOptions());

    mqttService.serverMqtt.value = server;
    mqttService.portServer.value = int.parse(port);
    mqttService.username.value = username;
    mqttService.password.value = password;

    mqttService.getClient().disconnect();
    await mqttService.mqttConnect();
    homePageService.lockDevice.value = true;
    EasyLoading.dismiss();
    requestService.endRequest();
    showNotification(title: 'Thay đổi thông tin server thành công');
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  //thêm dữ liệu quan trắc
  Future<void> addDuLieu(DuLieuQuanTracModel requestModel) async {
    await requestService.postRequestWithoutToken(urlAddDuLieu, {});
  }

  //lấy dữ liệu quan trắc
  Future<void> getDuLieu(DuLieuQuanTracModel requestModel) async {
    requestService.startRequest(
        title:
            "Lấy dữ liệu không thành công. Kiểm tra kết nối mạng của thiết bị");
    final response = await requestService.getRequestWithoutToken(
        urlGetDuLieu, {'q': '${homePageService.mapSetup["thietBiId"]}'});

    homePageService.pHDataList.clear();
    homePageService.dataQuanTracList.clear();

    for (var element in response['data']) {
      //xóa bớt ký tự k cần thiết ở dữ liệu time
      String m = (element["ngayTao"]).toString().replaceRange(10, 11, '     ');
      String dateTime = m.replaceRange(23, null, '');
      homePageService.dataQuanTracList.add({
        dateTime,
        element["pH"],
        element["cod"],
        element["bod"],
        element["tss"],
        element["nh4"],
        element["temp"],
      });
    }
    requestService.endRequest();
  }
}
