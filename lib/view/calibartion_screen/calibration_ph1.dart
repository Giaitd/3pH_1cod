import 'dart:async';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_ph_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/calibration_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';

class CalibrationpH1 extends StatefulWidget {
  const CalibrationpH1({Key? key}) : super(key: key);

  @override
  State<CalibrationpH1> createState() => _CalibrationpH1State();
}

class _CalibrationpH1State extends State<CalibrationpH1> {
  HomePageService homePageService = Get.put(HomePageService());
  SecureStorage storage = Get.put(SecureStorage());
  CalibrationService calibrationService = Get.put(CalibrationService());
  Timer? timer1;

  @override
  void initState() {
    super.initState();
    if (timer1 != null) timer1!.cancel();
    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      calibrationService.calibrationPH1();
      calibrationService.calibpH1Zero.value = false;
      calibrationService.calibpH1SlopeLo.value = false;
      calibrationService.calibpH1SlopeHi.value = false;
    });
  }

  @override
  void dispose() {
    timer1!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: calibrationPHTemplate(context,
            calibZero: calibrationService.calibpH1Zero.value,
            calibSlopeHi: calibrationService.calibpH1SlopeHi.value,
            calibSlopeLo: calibrationService.calibpH1SlopeLo.value,
            realData: homePageService.pH1.value.toString(),
            offsetReal: homePageService.mapSetup["offsetpH1"],
            number: 5,
            offsetValue: homePageService.offsetpH1.value),
      ),
    );
  }
}
