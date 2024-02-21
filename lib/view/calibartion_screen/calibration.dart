import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/common/simple_appbar.dart';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_cod.dart';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_ph1.dart';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_ph2.dart';
import 'package:do_ph_cod_hongphat/view/calibartion_screen/calibration_ph3.dart';
import '../../services/homepage_service.dart';

class Calibration extends StatefulWidget {
  const Calibration({Key? key}) : super(key: key);

  @override
  State<Calibration> createState() => _CalibrationState();
}

class _CalibrationState extends State<Calibration> {
  HomePageService homePageService = Get.put(HomePageService());
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        appBar: simpleAppBar(context, title: 'Hiệu chuẩn đầu đo'),
        body: SingleChildScrollView(
          child: Container(
            height: 700 / sizeDevice,
            width: 1365 / sizeDevice,
            color: const Color(0xFFF0F0F0),
            child: Column(
              children: [
                SizedBox(
                  height: 700 / sizeDevice,
                  width: 1365 / sizeDevice,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 85 / sizeDevice,
                        width: 1365 / sizeDevice,
                        child: Row(
                          children: [
                            //Hiệu chuẩn đầu đo pH1
                            SizedBox(
                              width: 273 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 0;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo pH1",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 0
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 0
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 170 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),
                            //Hiệu chuẩn đầu đo pH2
                            SizedBox(
                              width: 273 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 1;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo pH2",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 1
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 1
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 170 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),

                            //Hiệu chuẩn đầu đo pH3
                            SizedBox(
                              width: 273 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 2;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo pH3",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 2
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 2
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 170 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),
                            //Hiệu chuẩn cod, bod
                            SizedBox(
                              width: 273 / sizeDevice,
                              height: 90 / sizeDevice,
                              child: Column(children: [
                                SizedBox(height: 24 / sizeDevice),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _number = 3;
                                    });
                                  },
                                  child: Text(
                                    "Đầu đo COD",
                                    style: TextStyle(
                                        fontSize: 34 / sizeDevice,
                                        fontWeight: FontWeight.bold,
                                        color: _number == 3
                                            ? const Color.fromARGB(
                                                255, 5, 148, 10)
                                            : Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 7 / sizeDevice, 0, 0),
                                ),
                                _number == 3
                                    ? Container(
                                        height: 5 / sizeDevice,
                                        width: 180 / sizeDevice,
                                        color: Colors.orange,
                                      )
                                    : Container()
                              ]),
                            ),

                            // // hiệu chuẩn TSS
                            // SizedBox(
                            //   width: 273 / sizeDevice,
                            //   height: 90 / sizeDevice,
                            //   child: Column(children: [
                            //     SizedBox(height: 24 / sizeDevice),
                            //     GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           _number = 4;
                            //         });
                            //       },
                            //       child: Text(
                            //         "Đầu đo TSS",
                            //         style: TextStyle(
                            //             fontSize: 34 / sizeDevice,
                            //             fontWeight: FontWeight.bold,
                            //             color: _number == 4
                            //                 ? const Color.fromARGB(
                            //                     255, 5, 148, 10)
                            //                 : Colors.black),
                            //       ),
                            //     ),
                            //     Container(
                            //       margin: EdgeInsets.fromLTRB(
                            //           0, 7 / sizeDevice, 0, 0),
                            //     ),
                            //     _number == 4
                            //         ? Container(
                            //             height: 5 / sizeDevice,
                            //             width: 200 / sizeDevice,
                            //             color: Colors.orange,
                            //           )
                            //         : Container()
                            //   ]),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                        width: 1300 / sizeDevice,
                      ),
                      _number == 0
                          ? const CalibrationpH1()
                          : (_number == 1
                              ? const CalibrationpH2()
                              : (_number == 2
                                  ? const CalibrationpH3()
                                  : const CalibrationCOD()))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
