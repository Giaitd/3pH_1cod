import 'dart:async';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_ph_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/calibration_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';

class CalibrationpH2 extends StatefulWidget {
  const CalibrationpH2({Key? key}) : super(key: key);

  @override
  State<CalibrationpH2> createState() => _CalibrationpH2State();
}

class _CalibrationpH2State extends State<CalibrationpH2> {
  HomePageService homePageService = Get.put(HomePageService());
  SecureStorage storage = Get.put(SecureStorage());
  CalibrationService calibrationService = Get.put(CalibrationService());
  Timer? timer2;

  @override
  void initState() {
    super.initState();
    if (timer2 != null) timer2!.cancel();
    timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      calibrationService.calibrationPH2();
      calibrationService.calibpH2Zero.value = false;
      calibrationService.calibpH2SlopeLo.value = false;
      calibrationService.calibpH2SlopeHi.value = false;
    });
  }

  @override
  void dispose() {
    timer2!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: calibrationPHTemplate(context,
            calibZero: calibrationService.calibpH2Zero.value,
            calibSlopeHi: calibrationService.calibpH2SlopeHi.value,
            calibSlopeLo: calibrationService.calibpH2SlopeLo.value,
            realData: homePageService.pH2.value.toString(),
            offsetReal: homePageService.mapSetup["offsetpH2"],
            number: 6,
            offsetValue: homePageService.offsetpH2.value),
      ),
    );
  }
}
