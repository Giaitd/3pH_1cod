import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helper/router.dart';

class RequestService extends GetxService {
  Timer? timer1;

  Future<dynamic> getRequestWithoutToken(
      String url, Map<String, dynamic> params,
      {dynamic body, Map<String, String>? headers}) async {
    Uri urlUri = Uri.parse(url).replace(queryParameters: params);
    final response = await http.get(
      urlUri,
      headers: {'Content-Type': 'application/json'},
    );
    try {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return {'status': response.statusCode, 'data': decodedData};
    } catch (e) {
      return {'status': response.statusCode, 'data': ''};
    }
  }

  Future<dynamic> postRequestWithoutToken(
      String url, Map<String, dynamic> params,
      {dynamic body, Map<String, String>? headers}) async {
    Uri urlUri = Uri.parse(url).replace(queryParameters: params);
    http.Response response = await http.post(
      urlUri,
      headers: {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      },
      body: json.encode(body),
    );
    try {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return {'status': response.statusCode, 'data': decodedData};
    } catch (e) {
      return {'status': response.statusCode, 'data': ''};
    }
  }

  void startRequest({int delay = 20, String title = ''}) {
    EasyLoading.show(status: 'loading...');
    if (timer1 != null) timer1!.cancel();
    timer1 = Timer(Duration(seconds: delay), () {
      showNotification(title: title);
      EasyLoading.dismiss();
    });
  }

  void endRequest() {
    if (timer1 != null) timer1!.cancel();
    EasyLoading.dismiss();
  }
}
