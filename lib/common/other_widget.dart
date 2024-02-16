import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/homepage_service.dart';
import '../view/flutter_flow/flutter_flow_theme.dart';

HomePageService homePageService = Get.put(HomePageService());
double sizeDevice = homePageService.sizeDevice.value;

buttonMenuWidget(BuildContext context,
    {String title = '', String image = '', Function? function}) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(
        30 / sizeDevice, 0, 30 / sizeDevice, 8 / sizeDevice),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x411D2429),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: GestureDetector(
        onTap: () {
          if (function != null) function();
        },
        child: Padding(
          padding: EdgeInsetsDirectional.all(8 / sizeDevice),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    5 / sizeDevice, 5 / sizeDevice, 0, 5 / sizeDevice),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6 / sizeDevice),
                  child: Image.asset(
                    image,
                    width: 70 / sizeDevice,
                    height: 70 / sizeDevice,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20 / sizeDevice, 0, 0, 0),
                  child: Text(
                    title,
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Roboto Mono',
                          color: const Color(0xFF0F1113),
                          fontSize: 28 / sizeDevice,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

dataRealtime(BuildContext context,
    {String name = '', String data = '', String donViDo = ''}) {
  return Container(
    margin: EdgeInsets.only(top: 25 / sizeDevice),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Color(0x411D2429),
          offset: Offset(0, 5),
        )
      ],
      // borderRadius: BorderRadius.circular(8 / sizeDevice),
    ),
    height: 90 / sizeDevice,
    width: 400 / sizeDevice,
    child: Row(children: [
      //tên
      Container(
        padding: EdgeInsets.only(left: 15 / sizeDevice),
        width: 100 / sizeDevice,
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style:
              TextStyle(fontSize: 30 / sizeDevice, fontWeight: FontWeight.w600),
        ),
      ),
      //giá trị đo được
      Container(
        width: 200 / sizeDevice,
        alignment: Alignment.center,
        child: Text(
          data,
          style:
              TextStyle(fontSize: 50 / sizeDevice, fontWeight: FontWeight.bold),
        ),
      ),
      //đơn vị đo
      Container(
        // margin: EdgeInsets.fromLTRB(0, 0, 15 / sizeDevice, 15 / sizeDevice),
        width: 100 / sizeDevice,
        alignment: Alignment.center,
        child: Text(
          donViDo,
          style: TextStyle(
              fontSize: 30 / sizeDevice,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
      ),
    ]),
  );
}
