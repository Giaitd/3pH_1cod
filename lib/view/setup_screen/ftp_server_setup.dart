import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import 'package:quantrac_online_hongphat/helper/router.dart';
import 'package:quantrac_online_hongphat/services/file_transfer_service.dart';
import 'package:quantrac_online_hongphat/services/mqtt_service.dart';
import 'package:quantrac_online_hongphat/services/server_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class FTPServerSetup extends StatefulWidget {
  const FTPServerSetup({Key? key}) : super(key: key);

  @override
  State<FTPServerSetup> createState() => _FTPServerSetupState();
}

class _FTPServerSetupState extends State<FTPServerSetup> {
  HomePageService homePageService = Get.put(HomePageService());
  SecureStorage storage = Get.put(SecureStorage());
  MqttService mqttService = Get.put(MqttService());
  ServerService serverService = Get.put(ServerService());
  FileTransferService fileTransferService = Get.put(FileTransferService());

  TextEditingController fileNameController = TextEditingController(text: "");
  TextEditingController folderController = TextEditingController(text: "");

  TextEditingController serverController = TextEditingController(text: "");
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController portController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        appBar: simpleAppBar(context, title: 'Cài đặt tên file lưu trữ'),
        body: SingleChildScrollView(
          child: Container(
            height: 700 / sizeDevice,
            width: 1365 / sizeDevice,
            color: const Color(0xFFF0F0F0),
            child: Row(
              children: [
                // ************************************************** cài đặt file lưu *******************************************************************
                SizedBox(
                  width: 670 / sizeDevice,
                  height: 700 / sizeDevice,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          20 / sizeDevice, 20 / sizeDevice, 0, 0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8 / sizeDevice),
                        border: Border.all(
                          color: const Color(0xFFF1F4F8),
                          width: 2 / sizeDevice,
                        ),
                      ),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 10 / sizeDevice, 0, 30 / sizeDevice),
                          child: Text(
                            'Cài đặt truyền file',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Roboto Mono',
                                  color: const Color(0xFF0F1113),
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),

                        //tên file
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 / sizeDevice, 10 / sizeDevice, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120 / sizeDevice,
                                child: Text(
                                  'Tên file', //TenTinh_TenCoso_TenTram_Thoigian.txt
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 22 / sizeDevice,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: 510 / sizeDevice,
                                padding: EdgeInsets.all(10 / sizeDevice),
                                child: TextFormField(
                                  readOnly: homePageService.lockDevice.value
                                      ? true
                                      : false,
                                  style: TextStyle(fontSize: 24 / sizeDevice),
                                  controller: fileNameController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: 'SVNGilroy',
                                        color: Colors.grey,
                                        fontSize: 24 / sizeDevice,
                                      ),
                                      hintText:
                                          fileTransferService.fileName.value,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //tên folder
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 / sizeDevice, 20 / sizeDevice, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120 / sizeDevice,
                                child: Text(
                                  'Tên folder', //TenTinh_TenCoso_TenTram_Thoigian.txt
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 22 / sizeDevice,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: 510 / sizeDevice,
                                padding: EdgeInsets.all(10 / sizeDevice),
                                child: TextFormField(
                                  readOnly: homePageService.lockDevice.value
                                      ? true
                                      : false,
                                  style: TextStyle(fontSize: 24 / sizeDevice),
                                  controller: folderController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: 'SVNGilroy',
                                        color: Colors.grey,
                                        fontSize: 24 / sizeDevice,
                                      ),
                                      hintText:
                                          fileTransferService.folder.value,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //text
                        Container(
                          padding: EdgeInsets.fromLTRB(10 / sizeDevice,
                              20 / sizeDevice, 10 / sizeDevice, 0),
                          child: Column(children: [
                            Text(
                                "- Tên file: là tên file lưu trữ dữ liệu quan trắc ở bộ nhớ trong của thiết bị.",
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Roboto Mono',
                                      color: const Color(0xFF0F1113),
                                      fontSize: 20 / sizeDevice,
                                      fontWeight: FontWeight.w500,
                                    )),
                            const SizedBox(height: 5),
                            Text(
                                "- Tên folder: là nơi lưu trữ dữ liệu quan trắc ở sở tài nguyên môi trường",
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Roboto Mono',
                                      color: const Color(0xFF0F1113),
                                      fontSize: 20 / sizeDevice,
                                      fontWeight: FontWeight.w500,
                                    )),
                            const SizedBox(height: 5),
                            Text(
                                "- Cách đặt tên file và folder phải tuân theo thông tư 10_2021_TT-BTNMT",
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Roboto Mono',
                                      color: const Color(0xFF0F1113),
                                      fontSize: 20 / sizeDevice,
                                      fontWeight: FontWeight.w500,
                                    ))
                          ]),
                        ),

                        //button save
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 60 / sizeDevice, 0, 30 / sizeDevice),
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
                                  await fileTransferService.setDataForTranfer(
                                      context,
                                      fileNameController.text,
                                      folderController.text);
                                  homePageService.lockDevice.value = true;
                                }
                              },
                              child: Text(
                                'Lưu',
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
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
                  ]),
                ),

                // cài đặt server FTP =========================================================================
                SizedBox(
                  width: 670 / sizeDevice,
                  height: 700 / sizeDevice,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          20 / sizeDevice, 20 / sizeDevice, 0, 0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8 / sizeDevice),
                        border: Border.all(
                          color: const Color(0xFFF1F4F8),
                          width: 2 / sizeDevice,
                        ),
                      ),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 10 / sizeDevice, 0, 30 / sizeDevice),
                          child: Text(
                            'Cài đặt server FTP',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Roboto Mono',
                                  color: const Color(0xFF0F1113),
                                  fontSize: 24 / sizeDevice,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),

                        //tên server
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 / sizeDevice, 10 / sizeDevice, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120 / sizeDevice,
                                child: Text(
                                  'Tên server',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 22 / sizeDevice,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: 510 / sizeDevice,
                                padding: EdgeInsets.all(10 / sizeDevice),
                                child: TextFormField(
                                  readOnly: homePageService.lockDevice.value
                                      ? true
                                      : false,
                                  style: TextStyle(fontSize: 24 / sizeDevice),
                                  controller: serverController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: 'SVNGilroy',
                                        color: Colors.grey,
                                        fontSize: 24 / sizeDevice,
                                      ),
                                      hintText: fileTransferService
                                          .ftpServerName.value,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //username
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 / sizeDevice, 20 / sizeDevice, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120 / sizeDevice,
                                child: Text(
                                  'Username', //TenTinh_TenCoso_TenTram_Thoigian.txt
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 22 / sizeDevice,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: 510 / sizeDevice,
                                padding: EdgeInsets.all(10 / sizeDevice),
                                child: TextFormField(
                                  readOnly: homePageService.lockDevice.value
                                      ? true
                                      : false,
                                  style: TextStyle(fontSize: 24 / sizeDevice),
                                  controller: userNameController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: 'SVNGilroy',
                                        color: Colors.grey,
                                        fontSize: 24 / sizeDevice,
                                      ),
                                      hintText:
                                          fileTransferService.ftpUsername.value,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //password
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 / sizeDevice, 20 / sizeDevice, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120 / sizeDevice,
                                child: Text(
                                  'Password',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 22 / sizeDevice,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: 510 / sizeDevice,
                                padding: EdgeInsets.all(10 / sizeDevice),
                                child: TextFormField(
                                  readOnly: homePageService.lockDevice.value
                                      ? true
                                      : false,
                                  style: TextStyle(fontSize: 24 / sizeDevice),
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: 'SVNGilroy',
                                        color: Colors.grey,
                                        fontSize: 24 / sizeDevice,
                                      ),
                                      hintText:
                                          fileTransferService.ftpPassword.value,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //port
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 / sizeDevice, 20 / sizeDevice, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120 / sizeDevice,
                                child: Text(
                                  'Port', //TenTinh_TenCoso_TenTram_Thoigian.txt
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        color: const Color(0xFF0F1113),
                                        fontSize: 22 / sizeDevice,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Container(
                                width: 510 / sizeDevice,
                                padding: EdgeInsets.all(10 / sizeDevice),
                                child: TextFormField(
                                  readOnly: homePageService.lockDevice.value
                                      ? true
                                      : false,
                                  style: TextStyle(fontSize: 24 / sizeDevice),
                                  controller: portController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: 'SVNGilroy',
                                        color: Colors.grey,
                                        fontSize: 24 / sizeDevice,
                                      ),
                                      hintText:
                                          fileTransferService.ftpPort.value,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //button save
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 30 / sizeDevice, 0, 30 / sizeDevice),
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
                                  await fileTransferService.setFTPServer(
                                      context,
                                      serverController.text,
                                      userNameController.text,
                                      passwordController.text,
                                      portController.text);
                                  homePageService.lockDevice.value = true;
                                }
                              },
                              child: Text(
                                'Lưu',
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
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
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
