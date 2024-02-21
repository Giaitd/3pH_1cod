import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/services/homepage_service.dart';

HomePageService homePageService = Get.put(HomePageService());

void toPage(BuildContext context, Widget page,
    {Transition transition = Transition.rightToLeft}) async {
  try {
    Get.to(page, transition: transition);
  } catch (e) {
    print('Hongphat Exception catched: e == $e');
  }
}

void showNotification(
    {String title =
        'Đọc kỹ hướng dẫn sử dụng, sau đó nhập mật khẩu mở khóa trước khi tiến hành hiệu chuẩn'}) async {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: title,
      fontSize: 24 / homePageService.sizeDevice.value,
      backgroundColor: Colors.red,
      gravity: ToastGravity.TOP);
}
