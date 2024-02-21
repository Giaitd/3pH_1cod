import 'package:do_ph_cod_hongphat/helper/router.dart';
import 'package:do_ph_cod_hongphat/view/setup_screen/set_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/homepage_service.dart';
import '../view/flutter_flow/flutter_flow_icon_button.dart';
import '../view/popup_screen/popup_screen.dart';

PreferredSize simpleAppBar(
  BuildContext context, {
  String title = '',
  Function? leadingFunction,
  Function? trailingFunction,
  bool isGetBack = true,
  bool leading = true,
  bool trailing = true,
}) {
  HomePageService homePageService = Get.put(HomePageService());
  double sizeDevice = homePageService.sizeDevice.value;
  return PreferredSize(
    preferredSize: Size.fromHeight(70 / sizeDevice),
    child: AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 81, 255),
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 150 / sizeDevice,
                  padding: EdgeInsets.fromLTRB(
                      35 / sizeDevice, 0, 35 / sizeDevice, 0),
                  child: leading == true
                      ? FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 40 / sizeDevice,
                          borderWidth: 1,
                          buttonSize: 80 / sizeDevice,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.black,
                            size: 60 / sizeDevice,
                          ),
                          onPressed: () async {
                            homePageService.lockDevice.value = true;
                            if (leadingFunction != null) {
                              leadingFunction();
                            } else if (isGetBack) {
                              Navigator.pop(context);
                            }
                          },
                          fillColor: Colors.white,
                        )
                      : GestureDetector(
                          child: Container(
                            color: const Color.fromARGB(255, 0, 81, 255),
                            width: 140 / sizeDevice,
                            height: 60 / sizeDevice,
                          ),
                          onLongPress: () {
                            toPage(context, const SetId());
                          },
                        ),
                ),
                SizedBox(
                  width: 1065 / sizeDevice,
                  child: Center(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Mono',
                            fontSize: 44 / sizeDevice,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                if (trailing == true)
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        35 / sizeDevice, 0, 35 / sizeDevice, 0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 40 / sizeDevice,
                      borderWidth: 1,
                      buttonSize: 80 / sizeDevice,
                      icon: Image.asset(
                        trailingFunction == null
                            ? homePageService.lockDevice.value
                                ? 'assets/images/locked.png'
                                : 'assets/images/unlocked.png'
                            : 'assets/images/menu.png',
                        fit: BoxFit.fitHeight,
                      ),
                      onPressed: () async {
                        if (trailingFunction != null) {
                          trailingFunction();
                        } else {
                          if (homePageService.lockDevice.value == false) {
                            homePageService.lockDevice.value = true;
                          } else {
                            PopupScreen().inputPassword(context, function: () {
                              homePageService.lockDevice.value = false;
                              Navigator.pop(context);
                            });
                          }
                        }
                      },
                      fillColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
