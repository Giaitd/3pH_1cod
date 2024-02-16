import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import 'package:quantrac_online_hongphat/helper/router.dart';
import 'package:quantrac_online_hongphat/model/duLieuQuanTrac_model.dart';
import 'package:quantrac_online_hongphat/services/mqtt_service.dart';
import 'package:quantrac_online_hongphat/view/menu/menu_widget.dart';
import 'package:quantrac_online_hongphat/view/main_screen/thongso_quantrac.dart';
import '../../services/server_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SecureStorage storage = Get.put(SecureStorage());
  HomePageService homePageService = Get.put(HomePageService());
  MqttService mqttService = Get.put(MqttService());
  Timer? timer1;
  late DuLieuQuanTracModel duLieuQuanTracModel;
  ServerService serverService = ServerService();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < homePageService.keySetup.length; i++) {
      storage.readDataSetup(i);
    }
    if (homePageService.check.value == false) {
      if (timer1 != null) timer1!.cancel();
      timer1 = Timer.periodic(const Duration(seconds: 60), (timer) {
        duLieuQuanTracModel = DuLieuQuanTracModel();
        duLieuQuanTracModel.thietBiId = homePageService.mapSetup["thietBiId"];
        duLieuQuanTracModel.pH1 = homePageService.pH1.value.toString();
        duLieuQuanTracModel.temp1 = homePageService.temp1.value.toString();
        duLieuQuanTracModel.pH2 = homePageService.pH2.value.toString();
        duLieuQuanTracModel.temp2 = homePageService.temp2.value.toString();
        duLieuQuanTracModel.pH3 = homePageService.pH3.value.toString();
        duLieuQuanTracModel.temp3 = homePageService.temp3.value.toString();
        duLieuQuanTracModel.bod = homePageService.bod.value.toString();
        duLieuQuanTracModel.cod = homePageService.cod.value.toString();
        duLieuQuanTracModel.tss = homePageService.tss.value.toString();

        serverService.addDuLieu(duLieuQuanTracModel);
      });
      homePageService.check.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      resizeToAvoidBottomInset: false,
      appBar: simpleAppBar(
        context,
        title: 'Bộ đo thông số nước thải',
        leading: false,
        trailingFunction: () {
          toPage(context, const MenuWidget());
        },
      ),
      body: const ThongSoQuanTrac(),
    );
  }
}
