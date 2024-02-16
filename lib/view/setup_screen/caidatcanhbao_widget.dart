import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantrac_online_hongphat/common/simple_appbar.dart';
import 'package:quantrac_online_hongphat/view/setup_screen/caidatcanhbao.dart';
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
        appBar: simpleAppBar(context, title: 'Cài đặt cảnh báo'),
        body: SingleChildScrollView(
          child: Container(
            height: 700 / sizeDevice,
            width: 1365 / sizeDevice,
            color: const Color(0xFFF0F0F0),
            child: Column(
              children: [
                SizedBox(height: 20 / sizeDevice),
                SizedBox(
                  height: 680 / sizeDevice,
                  width: 1365 / sizeDevice,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 35 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Thông số cảnh báo: Là giới hạn tối đa của các thông số nước thải mà đầu ra vẫn đảm bảo được tiêu chuẩn thiết kế nước thải loại A, loại B...",
                        style: TextStyle(
                          fontSize: 28 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          35 / sizeDevice, 15 / sizeDevice, 35 / sizeDevice, 0),
                      child: Text(
                        "- Nếu giá trị quan trắc vượt quá các giới hạn này, hệ thống sẽ gửi thông tin cảnh báo về sở tài nguyên môi trường, về đơn vị sử dụng và nhà sản xuất để có phương án xử lý tiếp theo.",
                        style: TextStyle(
                          fontSize: 28 / sizeDevice,
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
