import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_ph_template.dart';
import '../../services/calibration_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';

class CalibrationpH3 extends StatefulWidget {
  const CalibrationpH3({Key? key}) : super(key: key);

  @override
  State<CalibrationpH3> createState() => _CalibrationpH3State();
}

class _CalibrationpH3State extends State<CalibrationpH3> {
  HomePageService homePageService = Get.put(HomePageService());
  SecureStorage storage = Get.put(SecureStorage());
  CalibrationService calibrationService = Get.put(CalibrationService());
  Timer? timer3;

  @override
  void initState() {
    super.initState();
    if (timer3 != null) timer3!.cancel();
    timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
      calibrationService.calibrationPH3();
      calibrationService.calibpH3Zero.value = false;
      calibrationService.calibpH3SlopeLo.value = false;
      calibrationService.calibpH3SlopeHi.value = false;
    });
  }

  @override
  void dispose() {
    timer3!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: calibrationPHTemplate(context,
              calibZero: calibrationService.calibpH3Zero.value,
              calibSlopeHi: calibrationService.calibpH3SlopeHi.value,
              calibSlopeLo: calibrationService.calibpH3SlopeLo.value,
              realData: homePageService.pH3.value.toString(),
              offsetReal: homePageService.mapSetup["offsetpH3"],
              number: 7,
              offsetValue: homePageService.offsetpH3.value),
        ));
  }
}
