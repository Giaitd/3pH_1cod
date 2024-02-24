import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/common/simple_appbar.dart';
import 'package:do_ph_cod_hongphat/view/setup_screen/caidatcanhbao.dart';
import '../../services/homepage_service.dart';

class CaiDatCanhBaoWidget extends StatefulWidget {
  const CaiDatCanhBaoWidget({Key? key}) : super(key: key);

  @override
  State<CaiDatCanhBaoWidget> createState() => _CaiDatCanhBaoWidget();
}

class _CaiDatCanhBaoWidget extends State<CaiDatCanhBaoWidget> {
  HomePageService homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        appBar:
            simpleAppBar(context, title: 'Cài đặt cảnh báo', password: '2009'),
        body: Container(
          height: 700 / sizeDevice,
          width: 1365 / sizeDevice,
          color: const Color(0xFFF0F0F0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 680 / sizeDevice,
                  width: 1365 / sizeDevice,
                  child: Column(children: [
                    Container(
                      width: 1365 / sizeDevice,
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 35 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Cài đặt các giới hạn để chạy bơm axit, kiềm, bơm dinh dưỡng.",
                        style: TextStyle(
                          fontSize: 26 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 1365 / sizeDevice,
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 35 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Giá trị pH nhỏ hơn pHmin thì chạy bơm bazo. Giá trị pH lớn hơn pHmax thì chạy bơm axit. Bơm axit và bazo sẽ dừng khi giá trị pH trở về khoảng giá trị được cài đặt sẵn.",
                        style: TextStyle(
                          fontSize: 26 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 1365 / sizeDevice,
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 35 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Giá trị COD nhỏ hơn giá trị cài đặt thì chạy bơm dinh dưỡng, lớn hơn giá trị này thì sẽ dừng bơm",
                        style: TextStyle(
                          fontSize: 26 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // data setup
                    const CaiDatCanhBao(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
