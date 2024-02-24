import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/services/homepage_service.dart';
import '../../services/secure_storage.dart';
import '../popup_screen/popup_screen.dart';

class CaiDatCanhBao extends StatefulWidget {
  const CaiDatCanhBao({Key? key}) : super(key: key);

  @override
  State<CaiDatCanhBao> createState() => _CaiDatCanhBaoState();
}

class _CaiDatCanhBaoState extends State<CaiDatCanhBao> {
  HomePageService homePageService = Get.put(HomePageService());
  @override
  Widget build(BuildContext context) {
    SecureStorage storage = Get.put(SecureStorage());
    double sizeDevice = homePageService.sizeDevice.value;
    late String _pHmin, _pHmax, _cod;

    return Obx(
      () => SizedBox(
        height: 450 / sizeDevice,
        width: 1365 / sizeDevice,
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                42 / sizeDevice, 42 / sizeDevice, 42 / sizeDevice, 0),
            child: Row(children: [
              //COD ============================================================================
              Container(
                height: 180 / sizeDevice,
                width: 350 / sizeDevice,
                color: const Color.fromRGBO(74, 89, 255, 1),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20 / sizeDevice, 0, 0),
                    child: Text(
                      "COD (mg/l)",
                      style: TextStyle(
                          fontSize: 32 / sizeDevice,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        100 / sizeDevice, 20 / sizeDevice, 100 / sizeDevice, 0),
                    child: TextFormField(
                      enabled: (!homePageService.lockDevice.value),
                      textAlign: TextAlign.center,
                      onChanged: (text) {
                        if (homePageService.lockDevice.value == false) {
                          _cod = text;
                          if (double.parse(_cod) < 1 ||
                              double.parse(_cod) > 200) {
                            PopupScreen().anounDialog(context);
                          } else {
                            homePageService.codSet.value = double.parse(_cod);
                            storage.writeDataSetup(2);
                            storage.readDataSetup(2);
                          }
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "${homePageService.mapSetup["codSet"]}",
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
                ]),
              ),
              SizedBox(width: 40 / sizeDevice),

              SizedBox(width: 40 / sizeDevice),

              //pH1
              Container(
                height: 180 / sizeDevice,
                width: 500 / sizeDevice,
                color: const Color.fromRGBO(74, 89, 255, 1),
                child: Row(children: [
                  //pH min =============================================================================
                  SizedBox(
                    width: 250 / sizeDevice,
                    height: 180 / sizeDevice,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            12 / sizeDevice, 20 / sizeDevice, 0, 0),
                        child: Text(
                          "pH1 min",
                          style: TextStyle(
                              fontSize: 32 / sizeDevice,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(56 / sizeDevice,
                            20 / sizeDevice, 44 / sizeDevice, 0),
                        child: TextFormField(
                          enabled: (!homePageService.lockDevice.value),
                          textAlign: TextAlign.center,
                          onChanged: (text) {
                            if (homePageService.lockDevice.value == false) {
                              _pHmin = text;
                              if (double.parse(_pHmin) < 1 ||
                                  double.parse(_pHmin) > 13) {
                                PopupScreen().anounDialog(context);
                              } else {
                                homePageService.pHMinSet.value =
                                    double.parse(_pHmin);
                                storage.writeDataSetup(0);
                                storage.readDataSetup(0);
                              }
                            }
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText:
                                  "${homePageService.mapSetup["pHMinSet"]}",
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
                    ]),
                  ),

                  //pH maxx =============================================================================
                  SizedBox(
                    width: 250 / sizeDevice,
                    height: 180 / sizeDevice,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0, 20 / sizeDevice, 12 / sizeDevice, 0),
                        child: Text(
                          "pH1 max",
                          style: TextStyle(
                              fontSize: 32 / sizeDevice,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(44 / sizeDevice,
                            20 / sizeDevice, 44 / sizeDevice, 0),
                        child: TextFormField(
                          enabled: (!homePageService.lockDevice.value),
                          textAlign: TextAlign.center,
                          onChanged: (text) {
                            if (homePageService.lockDevice.value == false) {
                              _pHmax = text;
                              if (double.parse(_pHmax) < 1 ||
                                  double.parse(_pHmax) > 13) {
                                PopupScreen().anounDialog(context);
                              } else {
                                homePageService.pHMaxSet.value =
                                    double.parse(_pHmax);
                                storage.writeDataSetup(1);
                                storage.readDataSetup(1);
                              }
                            }
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText:
                                  "${homePageService.mapSetup["pHMaxSet"]}",
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
                    ]),
                  ),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
