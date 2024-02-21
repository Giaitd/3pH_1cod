import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/common/simple_appbar.dart';
import '../../services/homepage_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  HomePageService homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Scaffold(
      appBar: simpleAppBar(context, trailing: false, title: 'Thông báo'),
      body: Container(
        height: 700 / sizeDevice,
        width: 1365 / sizeDevice,
        color: const Color(0xFFF0F0F0),
        child: Column(
          children: [
            SizedBox(height: 20 / sizeDevice),
            SizedBox(
              height: 680 / sizeDevice,
              width: 1365 / sizeDevice,
            )
          ],
        ),
      ),
    );
  }
}
