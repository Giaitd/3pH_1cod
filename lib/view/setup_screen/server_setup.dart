import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import 'package:quantrac_online_hongphat/helper/router.dart';
import 'package:quantrac_online_hongphat/services/mqtt_service.dart';
import 'package:quantrac_online_hongphat/services/server_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class ServerSetupWidget extends StatefulWidget {
  const ServerSetupWidget({Key? key}) : super(key: key);

  @override
  State<ServerSetupWidget> createState() => _ServerSetupWidgetState();
}

class _ServerSetupWidgetState extends State<ServerSetupWidget> {
  HomePageService homePageService = Get.put(HomePageService());
  SecureStorage storage = Get.put(SecureStorage());
  MqttService mqttService = Get.put(MqttService());
  ServerService serverService = Get.put(ServerService());

  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController serverController = TextEditingController(text: "");
  TextEditingController portController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        appBar: simpleAppBar(context, title: 'Cài đặt server'),
        body: SingleChildScrollView(
          child: Container(
            height: 700 / sizeDevice,
            width: 1365 / sizeDevice,
            color: const Color(0xFFF0F0F0),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 80 / sizeDevice),
                child: Row(
                  children: [
                    //server - port  ============================================================================
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          25 / sizeDevice, 0, 20 / sizeDevice, 0),
                      width: 650 / sizeDevice,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8 / sizeDevice),
                        border: Border.all(
                          color: const Color(0xFFF1F4F8),
                          width: 2 / sizeDevice,
                        ),
                      ),
                      child: Column(children: [
                        //server=============================
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(0, 10 / sizeDevice, 0, 0),
                          child: Text(
                            'Server',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Roboto Mono',
                                  color: const Color(0xFF0F1113),
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20 / sizeDevice),
                          child: TextFormField(
                            readOnly:
                                homePageService.lockDevice.value ? true : false,
                            style: TextStyle(fontSize: 24 / sizeDevice),
                            controller: serverController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontFamily: 'SVNGilroy',
                                  color: Colors.grey,
                                  fontSize: 24 / sizeDevice,
                                ),
                                hintText: mqttService.serverMqtt.value,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                            keyboardType: TextInputType.text,
                          ),
                        ),

                        //port =============================
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(0, 30 / sizeDevice, 0, 0),
                          child: Text(
                            'Port',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Roboto Mono',
                                  color: const Color(0xFF0F1113),
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20 / sizeDevice),
                          child: TextFormField(
                            readOnly:
                                homePageService.lockDevice.value ? true : false,
                            style: TextStyle(fontSize: 24 / sizeDevice),
                            controller: portController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontFamily: 'SVNGilroy',
                                  color: Colors.grey,
                                  fontSize: 24 / sizeDevice,
                                ),
                                hintText:
                                    mqttService.portServer.value.toString(),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ]),
                    ),

                    //username - password ========================================================================
                    Container(
                      width: 650 / sizeDevice,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8 / sizeDevice),
                        border: Border.all(
                          color: const Color(0xFFF1F4F8),
                          width: 2 / sizeDevice,
                        ),
                      ),
                      child: Column(children: [
                        //username ===================================
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(0, 10 / sizeDevice, 0, 0),
                          child: Text(
                            'username',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Roboto Mono',
                                  color: const Color(0xFF0F1113),
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20 / sizeDevice),
                          child: TextFormField(
                            readOnly:
                                homePageService.lockDevice.value ? true : false,
                            style: TextStyle(fontSize: 24 / sizeDevice),
                            controller: usernameController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontFamily: 'SVNGilroy',
                                  color: Colors.grey,
                                  fontSize: 24 / sizeDevice,
                                ),
                                hintText: mqttService.username.value,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                            keyboardType: TextInputType.text,
                          ),
                        ),

                        //password ==================================
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(0, 30 / sizeDevice, 0, 0),
                          child: Text(
                            'password',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Roboto Mono',
                                  color: const Color(0xFF0F1113),
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20 / sizeDevice),
                          child: TextFormField(
                            readOnly:
                                homePageService.lockDevice.value ? true : false,
                            style: TextStyle(fontSize: 24 / sizeDevice),
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontFamily: 'SVNGilroy',
                                  color: Colors.grey,
                                  fontSize: 24 / sizeDevice,
                                ),
                                hintText: mqttService.password.value,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),

              //button save
              Container(
                  margin: EdgeInsets.fromLTRB(0, 30 / sizeDevice, 0, 0),
                  width: 350 / sizeDevice,
                  height: 80 / sizeDevice,
                  color: Colors.green,
                  child: OutlinedButton(
                    onPressed: () async {
                      if (homePageService.lockDevice.value == true) {
                        showNotification(
                            title:
                                'Nhập mật khẩu để mở khóa trước khi thực hiện chức năng này');
                      } else {
                        EasyLoading.show(status: 'Loading...');
                        await serverService.changeServer(
                            context,
                            serverController.text,
                            portController.text,
                            usernameController.text,
                            passwordController.text);
                        homePageService.lockDevice.value = true;
                      }
                    },
                    child: Text(
                      'Lưu',
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Roboto Mono',
                            color: Colors.white,
                            fontSize: 30 / sizeDevice,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(10 / sizeDevice))),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
