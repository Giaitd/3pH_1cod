import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/services/homepage_service.dart';
import '../../common/simple_appbar.dart';
import '../../helper/router.dart';
import '../popup_screen/popup_screen.dart';

class SetId extends StatefulWidget {
  const SetId({Key? key}) : super(key: key);

  @override
  State<SetId> createState() => _SetIdState();
}

class _SetIdState extends State<SetId> {
  HomePageService homePageService = Get.put(HomePageService());

  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      homePageService.setupID();
      if (!homePageService.offSetID.value) {
        homePageService.setID.value = false;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _id1 = '';
  String _id2 = '';
  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: simpleAppBar(context, title: 'Cài đặt ID đầu đo pH'),
        body: Container(
          height: 700 / sizeDevice,
          width: 1365 / sizeDevice,
          color: const Color(0xFFF0F0F0),
          child: Column(
            children: [
              SizedBox(height: 20 / sizeDevice),
              SizedBox(
                width: 1365 / sizeDevice,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      30 / sizeDevice, 0, 0, 15 / sizeDevice),
                  child: Text(
                    'Lưu ý:',
                    style: TextStyle(
                        fontSize: 30 / sizeDevice,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    20 / sizeDevice, 0, 10 / sizeDevice, 0),
                child: SizedBox(
                  height: 250 / sizeDevice,
                  child: Image.asset(
                    'assets/images/change_id.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10 / sizeDevice,
                    20 / sizeDevice, 10 / sizeDevice, 20 / sizeDevice),
                child: SizedBox(
                  width: 1300 / sizeDevice,
                  child: Image.asset(
                    'assets/images/line.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 200 / sizeDevice),
                  Container(
                      height: 190 / sizeDevice,
                      width: 410 / sizeDevice,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/set_id.png',
                          ).image,
                        ),
                      ),
                      child: Column(
                        children: [
                          //id cũ
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                200 / sizeDevice, 20 / sizeDevice, 0, 0),
                            child: Container(
                              height: 65 / sizeDevice,
                              width: 160 / sizeDevice,
                              color: Colors.white,
                              child: Center(
                                child: TextFormField(
                                  enabled: (!homePageService.lockDevice.value),
                                  textAlign: TextAlign.center,
                                  onChanged: (text) => {
                                    _id1 = text,
                                    homePageService.idOld.value =
                                        int.parse(_id1),
                                  },
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    hintText: 'nhập id cũ',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontFamily: 'Roboto Mono',
                                    color: Colors.black,
                                    fontSize: 26 / sizeDevice,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //id mới
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                200 / sizeDevice, 20 / sizeDevice, 0, 0),
                            child: Container(
                              height: 65 / sizeDevice,
                              width: 160 / sizeDevice,
                              color: Colors.white,
                              child: Center(
                                child: TextFormField(
                                  enabled: (!homePageService.lockDevice.value),
                                  textAlign: TextAlign.center,
                                  onChanged: (text) => {
                                    _id2 = text,
                                    homePageService.idNew.value =
                                        int.parse(_id2),
                                  },
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    hintText: 'nhập id mới',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontFamily: 'Roboto Mono',
                                    color: Colors.black,
                                    fontSize: 26 / sizeDevice,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        80 / sizeDevice, 110 / sizeDevice, 0, 0),
                    child: SizedBox(
                      height: 70 / sizeDevice,
                      width: 140 / sizeDevice,
                      child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (homePageService.lockDevice.value == false) {
                                if (int.parse(_id2) < 6 ||
                                    int.parse(_id2) > 13 ||
                                    int.parse(_id1) < 6 ||
                                    int.parse(_id1) > 13 ||
                                    int.parse(_id2) == int.parse(_id1)) {
                                  PopupScreen().anounDialog(context);
                                } else {
                                  homePageService.setID.value = true;
                                }
                              } else {
                                showNotification();
                              }
                            });
                          },
                          child: Text(
                            'Set id',
                            style: TextStyle(
                              fontFamily: 'Roboto Mono',
                              color: homePageService.setID.value == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 30 / sizeDevice,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  homePageService.setID.value == true
                                      ? Colors.green
                                      : const Color(0xFFC0C0C0),
                              side: const BorderSide(color: Colors.black))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
