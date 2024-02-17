import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import 'package:quantrac_online_hongphat/helper/router.dart';
import 'package:quantrac_online_hongphat/services/homepage_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quantrac_online_hongphat/services/server_service.dart';
import 'package:quantrac_online_hongphat/view/calibartion_screen/calibration.dart';
import 'package:quantrac_online_hongphat/view/dulieuquantrac/dulieuquantrac_widget.dart';
import 'package:quantrac_online_hongphat/view/qrcode/generate_qrcode.dart';
import 'package:quantrac_online_hongphat/view/setup_screen/caidatcanhbao_widget.dart';
import '../../common/other_widget.dart';
import '../../model/duLieuQuanTrac_model.dart';
import '../notification_screen/notification.dart';
import '../setup_screen/server_setup.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    HomePageService homePageService = Get.put(HomePageService());
    ServerService serverService = Get.put(ServerService());

    double sizeDevice = homePageService.sizeDevice.value;
    DuLieuQuanTracModel duLieuQuanTracModel = DuLieuQuanTracModel();
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: simpleAppBar(context, title: 'Menu', trailing: false),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 20 / sizeDevice),
                buttonMenuWidget(context,
                    title: 'Thông báo',
                    image: 'assets/images/thongbao.png', function: () {
                  toPage(context, const NotificationScreen());
                }),
                buttonMenuWidget(context,
                    title: 'Dữ liệu quan trắc',
                    image: 'assets/images/dulieu.png', function: () async {
                  await serverService.getDuLieu(duLieuQuanTracModel);
                  homePageService.listData.clear();
                  for (int i = homePageService.dataQuanTracList.length - 1;
                      i >= 0;
                      i--) {
                    //giới hạn data xem trên thiết bị là 200 data mới nhất
                    if (homePageService.listData.length < 200) {
                      homePageService.listData
                          .add(homePageService.dataQuanTracList[i]);
                    } else {
                      break;
                    }
                  }
                  toPage(context, const DulieuQuanTracWidget());
                }),
                buttonMenuWidget(context,
                    title: 'Cài đặt cảnh báo',
                    image: 'assets/images/caidat.png', function: () async {
                  toPage(context, const CaiDatCanhBaoWidget());
                }),
                buttonMenuWidget(context,
                    title: 'Hiệu chuẩn đầu đo',
                    image: 'assets/images/hieuchuan.png', function: () async {
                  toPage(context, const Calibration());
                }),
                buttonMenuWidget(context,
                    title: 'Cài đặt server',
                    image: 'assets/images/server.png', function: () async {
                  toPage(context, const ServerSetupWidget());
                }),
                buttonMenuWidget(context,
                    title: 'Mã QR code',
                    image: 'assets/images/qrcode.png', function: () async {
                  toPage(context, const GenerateQRCode());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
