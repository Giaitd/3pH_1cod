import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/helper/router.dart';
import 'package:do_ph_cod_hongphat/services/calibration_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';
import '../popup_screen/popup_screen.dart';

class CalibrationCOD extends StatefulWidget {
  const CalibrationCOD({Key? key}) : super(key: key);

  @override
  State<CalibrationCOD> createState() => _CalibrationCODState();
}

class _CalibrationCODState extends State<CalibrationCOD> {
  HomePageService homePageService = Get.put(HomePageService());
  CalibrationService calibrationService = Get.put(CalibrationService());
  SecureStorage storage = Get.put(SecureStorage());
  Timer? timer3;

  @override
  void initState() {
    super.initState();
    if (timer3 != null) timer3!.cancel();
    timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
      calibrationService.calibrationCOD();
      calibrationService.calibCODDefault.value = false;
      calibrationService.turnOnBrush.value = false;
      calibrationService.calibCODSensor.value = false;
    });
  }

  @override
  void dispose() {
    timer3!.cancel();
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //text hướng dẫn
          Padding(
            padding: EdgeInsets.only(left: 230 / sizeDevice),
            child: Text(
              "ĐỌC KỸ HƯỚNG DẪN SỬ DỤNG TRƯỚC KHI TIẾN HÀNH HIỆU CHUẨN",
              style: TextStyle(
                  fontSize: 26 / sizeDevice, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Nhấn nút “Vệ sinh đầu đo” để thiết bị tự vệ sinh. Sau đó rửa sạch đầu đo với nước sạch. ",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Nhấn chọn “Hiệu chuẩn về mặc đinh” trước khi tiến hành các bước tiếp theo",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Nhúng đầu đo vào nước tinh khiết (nước cất hoặc nước khử ion) đảm bảo phần cảm biến ngập sâu trong nước ít nhất 2 cm. Đợi 1 phút cho giá trị đọc ổn định. Nhập giá trị COD đo được vào cột X.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Nhúng đầu đo vào dung dịch chuẩn 150mg/l COD với yêu cầu như trên. Sau đó nhập giá trị COD đo được vào cột Y.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Nhấn nút “Hiệu chuẩn” để tiến hành hiệu chuẩn.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),

          //nhập thông số
          Container(
            margin: EdgeInsets.fromLTRB(0, 30 / sizeDevice, 0, 0),
            child: Row(children: [
              Container(
                width: 382 / sizeDevice,
                height: 235 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Column(children: [
                  //cod =======
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
                            "COD",
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
                            "${homePageService.cod.value}",
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

                  //offset COD
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
                                "(-2.0 -> 2.0)",
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
                                homePageService.offsetCOD.value =
                                    double.parse(text);
                                storage.writeDataSetup(8);
                                storage.readDataSetup(8);
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: homePageService.mapSetup["offsetCOD"],
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
              Container(width: 20 / sizeDevice),
              Column(
                children: [
                  Container(
                    width: 324 / sizeDevice,
                    height: 110 / sizeDevice,
                    color: const Color.fromARGB(255, 166, 219, 221),
                    child: Column(
                      children: [
                        Container(
                          width: 250 / sizeDevice,
                          height: 90 / sizeDevice,
                          margin: EdgeInsets.fromLTRB(0, 10 / sizeDevice, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (homePageService.lockDevice.value == false) {
                                setState(() {
                                  calibrationService.turnOnBrush.value = true;
                                  homePageService.lockDevice.value = true;
                                });
                              } else {
                                showNotification();
                              }
                            },
                            child: Container(
                              height: 90 / sizeDevice,
                              width: 250 / sizeDevice,
                              alignment: Alignment.center,
                              // color: const Color(0xFF4657ef),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(height: 10 / sizeDevice),
                                  Text(
                                    "Vệ sinh",
                                    style: TextStyle(
                                        fontSize: 30 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: calibrationService
                                                    .turnOnBrush.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
                                  ),
                                  Text(
                                    "đầu đo",
                                    style: TextStyle(
                                        fontSize: 30 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: calibrationService
                                                    .turnOnBrush.value ==
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15 / sizeDevice),
                  Container(
                    width: 324 / sizeDevice,
                    height: 110 / sizeDevice,
                    color: const Color.fromARGB(255, 166, 219, 221),
                    child: Column(
                      children: [
                        Container(
                          width: 250 / sizeDevice,
                          height: 90 / sizeDevice,
                          margin: EdgeInsets.fromLTRB(0, 10 / sizeDevice, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (homePageService.lockDevice.value == false) {
                                setState(() {
                                  calibrationService.calibCODDefault.value =
                                      true;
                                  homePageService.lockDevice.value = true;
                                });
                              } else {
                                showNotification();
                              }
                            },
                            child: Container(
                              height: 90 / sizeDevice,
                              width: 250 / sizeDevice,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(height: 10 / sizeDevice),
                                  Text(
                                    "Hiệu chuẩn",
                                    style: TextStyle(
                                        fontSize: 30 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: calibrationService
                                                    .calibCODDefault.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
                                  ),
                                  Text(
                                    "về mặc định",
                                    style: TextStyle(
                                        fontSize: 30 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: calibrationService
                                                    .calibCODDefault.value ==
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(width: 20 / sizeDevice),

              // hiệu chuẩn theo x và y
              Container(
                width: 534 / sizeDevice,
                height: 235 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      15 / sizeDevice, 20 / sizeDevice, 15 / sizeDevice, 0),
                  width: 255 / sizeDevice,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 55 / sizeDevice,
                            height: 60 / sizeDevice,
                            child: Text(
                              "X",
                              style: TextStyle(
                                  fontSize: 36 / sizeDevice,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 160 / sizeDevice,
                            height: 80 / sizeDevice,
                            child: TextFormField(
                              enabled: (!homePageService.lockDevice.value),
                              textAlign: TextAlign.center,
                              onChanged: (text) {
                                setState(() {
                                  calibrationService.X.value =
                                      double.parse(text);
                                });
                              },
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero)),
                              style: TextStyle(
                                fontSize: 34 / sizeDevice,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 72 / sizeDevice),
                          SizedBox(
                            width: 160 / sizeDevice,
                            height: 80 / sizeDevice,
                            child: TextFormField(
                              enabled: (!homePageService.lockDevice.value),
                              textAlign: TextAlign.center,
                              onChanged: (text) {
                                setState(() {
                                  calibrationService.Y.value =
                                      double.parse(text);
                                });
                              },
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero)),
                              style: TextStyle(
                                fontSize: 34 / sizeDevice,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 55 / sizeDevice,
                            height: 60 / sizeDevice,
                            child: Text(
                              "Y",
                              style: TextStyle(
                                  fontSize: 36 / sizeDevice,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15 / sizeDevice),
                      ElevatedButton(
                        onPressed: () {
                          if (homePageService.lockDevice.value == false) {
                            setState(() {
                              calibrationService.calibCODSensor.value = true;
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
                          child: Text(
                            "Hiệu chuẩn",
                            style: TextStyle(
                                fontSize: 30 / sizeDevice,
                                fontWeight: FontWeight.bold,
                                color:
                                    calibrationService.calibCODSensor.value ==
                                            true
                                        ? Colors.red
                                        : Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
