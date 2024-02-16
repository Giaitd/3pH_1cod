import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import 'package:quantrac_online_hongphat/view/dulieuquantrac/dulieuquantrac.dart';
import '../../services/homepage_service.dart';

class DulieuQuanTracWidget extends StatefulWidget {
  const DulieuQuanTracWidget({Key? key}) : super(key: key);

  @override
  State<DulieuQuanTracWidget> createState() => _DulieuQuanTracWidgetState();
}

class _DulieuQuanTracWidgetState extends State<DulieuQuanTracWidget> {
  HomePageService homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Scaffold(
      appBar:
          simpleAppBar(context, title: 'Dữ liệu quan trắc', trailing: false),
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
              child: const Scrollbar(child: DuLieuQuanTrac(), thickness: 15),
            )
          ],
        ),
      ),
    );
  }
}
