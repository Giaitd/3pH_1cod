import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import '../../services/homepage_service.dart';

class CaiDatLayMauWidget extends StatefulWidget {
  const CaiDatLayMauWidget({Key? key}) : super(key: key);

  @override
  State<CaiDatLayMauWidget> createState() => _CaiDatLayMauWidget();
}

class _CaiDatLayMauWidget extends State<CaiDatLayMauWidget> {
  HomePageService homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        appBar: simpleAppBar(context, title: 'Cài đặt lấy mẫu'),
        body: SingleChildScrollView(
          child: Container(
            height: 700 / sizeDevice,
            width: 1365 / sizeDevice,
            color: const Color(0xFFF0F0F0),
            child: Column(
              children: [
                SizedBox(height: 20 / sizeDevice),
                SizedBox(
                  height: 680 / sizeDevice,
                  width: 1365 / sizeDevice,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 35 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "Chu kì lấy mẫu",
                        style: TextStyle(
                          fontSize: 28 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
