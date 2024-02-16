import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/helper/router.dart';
import 'package:quantrac_online_hongphat/view/calibartion_screen/calibration.dart';
import 'package:quantrac_online_hongphat/view/dulieuquantrac/dulieuquantrac_widget.dart';
import 'package:quantrac_online_hongphat/view/notification_screen/notification.dart';
import 'package:quantrac_online_hongphat/view/qrcode/generate_qrcode.dart';
import 'package:quantrac_online_hongphat/view/setup_screen/caidatcanhbao_widget.dart';
import '../../services/server_service.dart';
import '../../model/duLieuQuanTrac_model.dart';
import '../../services/homepage_service.dart';

class Data {
  final String title;
  Widget screen;

  Data({
    required this.title,
    required this.screen,
  });
}

class PopupScreen extends StatelessWidget {
  HomePageService homePageService = Get.put(HomePageService());
  ServerService serverService = Get.put(ServerService());
  PopupScreen({Key? key}) : super(key: key);
  late DuLieuQuanTracModel duLieuQuanTracModel;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<Data> menu = [
    Data(
      title: 'Thông báo',
      screen: const NotificationScreen(),
    ),
    Data(
      title: 'Dữ liệu quan trắc',
      screen: const DulieuQuanTracWidget(),
    ),
    Data(
      title: 'Cài đặt cảnh báo',
      screen: const CaiDatCanhBaoWidget(),
    ),
    Data(
      title: 'Hiệu chuẩn đầu đo',
      screen: const Calibration(),
    ),
    Data(
      title: 'QRCode',
      screen: const GenerateQRCode(),
    ),
  ];

  //Menu option
  menuOption(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text(
                'Menu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: Colors.black,
                  fontSize: 38 / homePageService.sizeDevice.value,
                  fontWeight: FontWeight.w600,
                ),
              ),
              children: [
                SizedBox(
                  height: 10 / sizeDevice,
                ),
                SizedBox(
                  height: 420 / sizeDevice,
                  width: 400 / sizeDevice,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final data = menu[index];
                      return SizedBox(
                        height: 90 / sizeDevice,
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            iconColor: Colors.black,
                            leading: Image.asset(
                              'assets/images/menu$index.png',
                              height: 60 / sizeDevice,
                              fit: BoxFit.fitHeight,
                            ),
                            title: Text(
                              data.title,
                              style: TextStyle(
                                  fontSize: 32 / sizeDevice,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () async {
                              if (index == 1) {
                                duLieuQuanTracModel = DuLieuQuanTracModel();
                                await serverService
                                    .getDuLieu(duLieuQuanTracModel);

                                homePageService.listData.clear();
                                for (int i = homePageService
                                            .dataQuanTracList.length -
                                        1;
                                    i >= 0;
                                    i--) {
                                  //giới hạn data xem trên thiết bị là 200 data mới nhất
                                  if (homePageService.listData.length < 200) {
                                    homePageService.listData.add(
                                        homePageService.dataQuanTracList[i]);
                                  } else {
                                    break;
                                  }
                                }

                                //vào giao diện dữ liệu quan trắc
                                toPage(context, data.screen);
                              } else {
                                toPage(context, data.screen);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ));
  }

  //thông số nhập sai
  anounDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                //cảnh báo
                'Cảnh báo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: const Color.fromARGB(255, 255, 0, 0),
                  fontSize: 36 / homePageService.sizeDevice.value,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                'Giá trị nhập không hợp lệ. Hãy nhập lại',
                style: TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: Colors.black,
                  fontSize: 26 / homePageService.sizeDevice.value,
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Đồng ý',
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      color: Colors.black,
                      fontSize: 26 / homePageService.sizeDevice.value,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(
                          10 / homePageService.sizeDevice.value))),
                )
              ],
            ));
  }

  inputPassword(BuildContext context,
      {Function? function,
      String password = 'hongphat2009',
      bool textKeyboard = true}) {
    double sizeDevice = homePageService.sizeDevice.value;
    String _password = '';
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: const Color(0xFFF0F0F0),
              children: [
                Container(
                  width: 500 / sizeDevice,
                  height: 170 / sizeDevice,
                  padding: EdgeInsets.fromLTRB(25 / sizeDevice, 10 / sizeDevice,
                      25 / sizeDevice, 10 / sizeDevice),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 40 / sizeDevice),
                        alignment: Alignment.center,
                        child: Text(
                          'Nhập mật khẩu',
                          style: TextStyle(
                              fontSize: 30 / sizeDevice,
                              fontFamily: 'Roboto Mono',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (text) => {
                          _password = text,
                          if (_password == password)
                            {
                              if (function != null) function(),
                            }
                        },
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '****',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto Mono',
                            color: Colors.black,
                            fontSize: 20 / sizeDevice,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: textKeyboard
                            ? TextInputType.text
                            : TextInputType.number,
                        style: TextStyle(
                          fontFamily: 'Roboto Mono',
                          color: Colors.black,
                          fontSize: 24 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }
}
