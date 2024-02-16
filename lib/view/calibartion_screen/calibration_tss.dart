import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/helper/router.dart';
import 'package:quantrac_online_hongphat/services/calibration_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';
import '../popup_screen/popup_screen.dart';

class CalibrationTSS extends StatefulWidget {
  const CalibrationTSS({Key? key}) : super(key: key);

  @override
  State<CalibrationTSS> createState() => _CalibrationTSSState();
}

class _CalibrationTSSState extends State<CalibrationTSS> {
  HomePageService homePageService = Get.put(HomePageService());
  SecureStorage storage = Get.put(SecureStorage());
  CalibrationService calibrationService = Get.put(CalibrationService());
  Timer? timer4;

  @override
  void initState() {
    super.initState();
    if (timer4 != null) timer4!.cancel();
    timer4 = Timer.periodic(const Duration(seconds: 1), (timer) {
      calibrationService.calibTSSZero.value = false;
      calibrationService.calibTSSSlope.value = false;
    });
  }

  @override
  void dispose() {
    timer4!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Container(
        width: 1365 / sizeDevice,
        height: 580 / sizeDevice,
        margin: EdgeInsets.fromLTRB(
            40 / sizeDevice, 30 / sizeDevice, 40 / sizeDevice, 0),
        child: Column(children: [
          //text hướng dẫn
          Text(
            "- Rửa sạch đầu đo với nước sạch hoặc nước cất sau đó thấm khô trước khi cho vào dung dịch hiệu chuẩn (không được lau)",
            style: TextStyle(
                fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Sử dụng đúng dung dịch dùng để hiệu chuẩn (nếu sử dụng sai dung dịch có thể dẫn đến hỏng hóc không khắc phục được). Đợi 5 phút để kết quả ổn định sau đó mới hiệu chuẩn nếu sai lệch",
            style: TextStyle(
                fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50 / sizeDevice, 10 / sizeDevice, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "+ Hiệu chuẩn zero: dùng nước siêu sạch: Nước tinh khiết đã qua bộ lọc 0.22 µm; độ dẫn điện ≤ 0.055µS/cm; TOC ≤ 5 µg/L",
                  style: TextStyle(
                      fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(height: 7 / sizeDevice),
                Text(
                  "+ Hiệu chuẩn slope: dùng dung dịch chuẩn TSS 1000mg/L",
                  style: TextStyle(
                      fontSize: 28 / sizeDevice, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          //nhập thông số
          Container(
            margin: EdgeInsets.fromLTRB(50 / sizeDevice, 30 / sizeDevice, 0, 0),
            // height: 235/sizeDevice,
            child: Row(children: [
              Container(
                width: 382 / sizeDevice,
                height: 235 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Column(children: [
                  //pH =======
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        12 / sizeDevice, 24 / sizeDevice, 27 / sizeDevice, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 183 / sizeDevice,
                          height: 80 / sizeDevice,
                          alignment: Alignment.center,
                          child: Text(
                            "TSS",
                            style: TextStyle(
                                fontSize: 28 / sizeDevice,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 160 / sizeDevice,
                          height: 80 / sizeDevice,
                          alignment: Alignment.center,
                          child: Text(
                            "${homePageService.tss.value}",
                            style: TextStyle(
                              fontSize: 34 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black, width: 1 / sizeDevice)),
                        ),
                      ],
                    ),
                  ),

                  //offset
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        12 / sizeDevice, 24 / sizeDevice, 27 / sizeDevice, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 183 / sizeDevice,
                          height: 80 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 9 / sizeDevice),
                              Text(
                                "Offset",
                                style: TextStyle(
                                    fontSize: 26 / sizeDevice,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(-0.5 -> 0.5)",
                                style: TextStyle(
                                    fontSize: 26 / sizeDevice,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 160 / sizeDevice,
                          height: 80 / sizeDevice,
                          child: TextFormField(
                            enabled: (!homePageService.lockDevice.value),
                            textAlign: TextAlign.center,
                            onChanged: (text) {
                              if (double.parse(text) < -2.0 ||
                                  double.parse(text) > 2.0) {
                                PopupScreen().anounDialog(context);
                              } else {
                                homePageService.offsetTSS.value =
                                    double.parse(text);
                                storage.writeDataSetup(10);
                                storage.readDataSetup(10);
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: homePageService.mapSetup["offsetNH4"],
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero)),
                            style: TextStyle(
                              fontSize: 34 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(
                width: 710 / sizeDevice,
                height: 235 / sizeDevice,
                margin: EdgeInsets.fromLTRB(80 / sizeDevice, 0, 0, 0),
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Row(children: [
                  //hiệu chuẩn  điểm 0
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        70 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (homePageService.lockDevice.value == false) {
                                setState(() {
                                  calibrationService.calibTSSZero.value = true;
                                  homePageService.lockDevice.value = true;
                                });
                              } else {
                                showNotification();
                              }
                            },
                            child: Container(
                              height: 100 / sizeDevice,
                              width: 250 / sizeDevice,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(height: 15 / sizeDevice),
                                  Text(
                                    "Hiệu chuẩn",
                                    style: TextStyle(
                                        fontSize: 30 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: calibrationService
                                                    .calibTSSZero.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
                                  ),
                                  Text(
                                    "điểm 0",
                                    style: TextStyle(
                                        fontSize: 30 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: calibrationService
                                                    .calibTSSZero.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4657ef)),
                          ),
                          SizedBox(height: 20 / sizeDevice),
                          Text("Sử dụng nước tinh khiết đã qua bộ lọc",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),

                  // hiệu chuẩn sloope
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        70 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (homePageService.lockDevice.value == false) {
                            setState(() {
                              calibrationService.calibTSSSlope.value = true;
                              homePageService.lockDevice.value = true;
                            });
                          } else {
                            showNotification();
                          }
                        },
                        child: Container(
                          height: 100 / sizeDevice,
                          width: 250 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 15 / sizeDevice),
                              Text(
                                "Hiệu chuẩn",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: calibrationService
                                                .calibTSSSlope.value ==
                                            true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                "slope",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: calibrationService
                                                .calibTSSSlope.value ==
                                            true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                      SizedBox(height: 20 / sizeDevice),
                      Text("Sử dụng dung dịch chuẩn 1000mg/L",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24 / sizeDevice,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                ]),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
