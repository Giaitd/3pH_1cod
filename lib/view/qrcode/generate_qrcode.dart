import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import '../../services/homepage_service.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  HomePageService homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    var a = {
      "androidboxInfo": "${homePageService.androidBoxInfo}",
      "serial": "0125"
    };

    return Scaffold(
      appBar: simpleAppBar(context,
          title: 'Mã QR Code của thiết bị', trailing: false),
      body: Container(
        height: 700 / sizeDevice,
        width: 1365 / sizeDevice,
        color: const Color(0xFFF0F0F0),
        child: Column(
          children: [
            Container(
              height: 100 / sizeDevice,
            ),
            Center(
              child: QrImage(
                data: a.toString(),
                size: 250 / sizeDevice,
                version: QrVersions.auto,
                eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square, color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 100 / sizeDevice, 0, 0),
              height: 200 / sizeDevice,
              child: Text(
                'Quét mã QRcode này để thêm thiết bị vào hệ thống',
                style: TextStyle(fontSize: 32 / sizeDevice),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
