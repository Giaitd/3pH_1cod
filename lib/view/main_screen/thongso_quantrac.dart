import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/other_widget.dart';
import '../../services/homepage_service.dart';

class ThongSoQuanTrac extends StatefulWidget {
  const ThongSoQuanTrac({Key? key}) : super(key: key);

  @override
  State<ThongSoQuanTrac> createState() => _ThongSoQuanTracState();
}

class _ThongSoQuanTracState extends State<ThongSoQuanTrac> {
  HomePageService homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;

    return Obx(
      () => SizedBox(
        height: 680 / sizeDevice,
        width: 1365 / sizeDevice,
        child: Row(children: [
          //bể điều hòa
          Container(
            margin: EdgeInsets.all(5 / sizeDevice),
            width: 445 / sizeDevice,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius:
                    BorderRadius.all(Radius.circular(15 / sizeDevice))),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 20 / sizeDevice),
                  child: Text('Bể điều hòa',
                      style: TextStyle(
                          fontSize: 35 / sizeDevice,
                          fontWeight: FontWeight.w600))),
              dataRealtime(context,
                  name: 'pH1', data: "${homePageService.pH1.value}"),
              dataRealtime(context,
                  name: 'temp',
                  data: "${homePageService.temp1.value}",
                  donViDo: 'oC'),
              Container(height: 230 / sizeDevice),
              getIOState(context, 'Phao bồn axit',
                  value: homePageService.i0[0]),
              getIOState(context, 'Phao bồn bazo',
                  value: homePageService.i0[1]),
              getIOState(context, 'Bơm axit', value: homePageService.q0[0]),
              getIOState(context, 'Bơm bazo', value: homePageService.q0[1]),
            ]),
          ),
          //bể hiếu khí
          Container(
            margin: EdgeInsets.all(5 / sizeDevice),
            width: 445 / sizeDevice,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius:
                    BorderRadius.all(Radius.circular(15 / sizeDevice))),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 20 / sizeDevice),
                child: Text('Bể thiếu khí',
                    style: TextStyle(
                        fontSize: 35 / sizeDevice,
                        fontWeight: FontWeight.w600)),
              ),
              dataRealtime(
                context,
                name: 'pH2',
                data: "${homePageService.pH2.value}",
              ),
              dataRealtime(context,
                  name: 'temp',
                  data: "${homePageService.temp2.value}",
                  donViDo: 'oC')
            ]),
          ),

          //bể thiếu khí
          Container(
            margin: EdgeInsets.all(5 / sizeDevice),
            width: 445 / sizeDevice,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius:
                    BorderRadius.all(Radius.circular(15 / sizeDevice))),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 20 / sizeDevice),
                  child: Text('Bể hiếu khí',
                      style: TextStyle(
                          fontSize: 35 / sizeDevice,
                          fontWeight: FontWeight.w600))),
              dataRealtime(
                context,
                name: 'pH3',
                data: "${homePageService.pH3.value}",
              ),
              dataRealtime(context,
                  name: 'COD',
                  data: "${homePageService.cod.value}",
                  donViDo: 'mg/L'),
              // dataRealtime(context,
              //     name: 'BOD',
              //     data: "${homePageService.bod.value}",
              //     donViDo: 'mg/L'),
              // dataRealtime(context,
              //     name: 'TSS',
              //     data: "${homePageService.tss.value}",
              //     donViDo: 'mg/L'),
              dataRealtime(context,
                  name: 'temp',
                  data: "${homePageService.temp3.value}",
                  donViDo: 'oC'),
              Container(height: 210 / sizeDevice),
              getIOState(context, 'Phao bồn dinh dưỡng',
                  value: homePageService.i0[2]),
              getIOState(context, 'Bơm dinh dưỡng',
                  value: homePageService.q0[2]),
            ]),
          )
        ]),
      ),
    );
  }
}
