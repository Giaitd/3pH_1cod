import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:quantrac_online_hongphat/services/homepage_service.dart';
import 'package:quantrac_online_hongphat/services/request_service.dart';
import 'url/url.dart';

class MqttService extends GetxService {
  final storage = const FlutterSecureStorage();
  RequestService requestService = Get.put(RequestService());
  HomePageService homePageService = Get.put(HomePageService());

  MqttServerClient? client;

  RxString serialDevice = ''.obs;
  String topic = '';
  RxString serverMqtt = 'hongphat41.egt.vn'.obs;
  RxInt portServer = 1883.obs;
  RxString username = 'hongphat_app'.obs;
  RxString password = '12345678'.obs;

  //dùng cho mqtt
  RxString enablePubMqtt = 'false'.obs;

  Timer? timer2;
  Timer? timer3;

  @override
  void onInit() {
    super.onInit();
    initFunction();

    if (timer3 != null) timer3!.cancel();
    timer3 = Timer.periodic(const Duration(seconds: 5), (timer) {
      publishMqtt();
    });

    //gửi trạng thái device lên app
    if (timer2 != null) timer2!.cancel();
    timer2 = Timer.periodic(const Duration(seconds: 10), (timer) {
      publishMqttToCheckOnline();
    });
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  void initFunction() async {
    String? s1 =
        (await storage.read(key: 'server', aOptions: _getAndroidOptions()))
            .toString();
    String? s2 =
        (await storage.read(key: 'port', aOptions: _getAndroidOptions()))
            .toString();
    username.value =
        (await storage.read(key: 'username', aOptions: _getAndroidOptions()))
            .toString();
    password.value =
        (await storage.read(key: 'password', aOptions: _getAndroidOptions()))
            .toString();
    if (s2 != 'null' && s1 != 'null') {
      serverMqtt.value = s1;
      portServer.value = int.parse(s2);
    }

    await homePageService.getDeviceInfo();
    await saveUserOwnerId();
    await mqttConnect();
  }

  //đây là topic để pub data
  Future<void> saveUserOwnerId() async {
    String? a =
        await storage.read(key: 'userOwnerId', aOptions: _getAndroidOptions());
    if (a == null) {
      print('mqtt======mqtt fetch server');
      var response = await requestService.getRequestWithoutToken(
          urlGetUserId, {'q': homePageService.androidBoxInfo.value});

      /// check urlGetUserId
      if (response['status'] == 200) {
        await storage.delete(
            key: 'userOwnerId', aOptions: _getAndroidOptions());
        await storage.write(
            key: 'userOwnerId',
            value: response['data']['mainUserId'].toString(),
            aOptions: _getAndroidOptions());
        await storage.delete(
            key: 'serialDevice', aOptions: _getAndroidOptions());
        await storage.write(
            key: 'serialDevice',
            value: response['data']['serial'].toString(),
            aOptions: _getAndroidOptions());
        topic = response['data']['mainUserId'].toString();
        serialDevice = response['data']['serial'];
      } else {
        topic = (await storage.read(
                key: 'userOwnerId', aOptions: _getAndroidOptions()))
            .toString();
        serialDevice.value = (await storage.read(
                key: 'serialDevice', aOptions: _getAndroidOptions()))
            .toString();
      }
    } else {
      print('mqtt======mqtt not fetch server');
      topic = a.toString();
      serialDevice.value = (await storage.read(
              key: 'serialDevice', aOptions: _getAndroidOptions()))
          .toString();
    }
  }

  //get client server
  MqttServerClient getClient() {
    client ??= MqttServerClient.withPort(serverMqtt.value,
        homePageService.androidBoxInfo.value.toString(), portServer.value);
    return client!;
  }

  //mqtt
  Future<void> mqttConnect() async {
    client ??= MqttServerClient.withPort(serverMqtt.value,
        homePageService.androidBoxInfo.value.toString(), portServer.value);

    client!.logging(on: false);
    client!.keepAlivePeriod = 20;
    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;
    client!.pongCallback = pong;
    client!.autoReconnect = true;
    client!.onSubscribed = onSubscribed;

    final connMess = MqttConnectMessage()
        .authenticateAs(username.value, password.value)
        .withClientIdentifier(homePageService
            .androidBoxInfo.value) //must be unique for each device
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('mqtt====client connecting....');
    client!.connectionMessage = connMess;
    try {
      await client!.connect();
      if (client!.connectionStatus!.state == MqttConnectionState.connected) {
        print('mqtt====client connected');
      } else {
        print('mqtt====connection failed, stt=${client!.connectionStatus}');
        client!.disconnect();
        exit(-1);
      }

      //subscription ========================================================
      client!.subscribe(topic, MqttQos.atMostOnce);

      /// The client has a change notifier object(see the Observable class) which we then listen to to get
      /// notifications of published updates to each subscribed topic.
      client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        Map<String, dynamic> data = jsonDecode(pt);
        if (data['status'] == "deviceReceive" &&
            data['serial'] == 'QT29052023') {
          var json = data['message'];
          enablePubMqtt.value = json['enablePubMqtt'];
        }
      });
    } catch (e) {
      print('mqtt====err = $e');
    }
  }

  //function publish data to mqtt
  publishMqtt() async {
    if (enablePubMqtt.value == "true") {
      final builder = MqttClientPayloadBuilder();
      builder.addString(json.encode({
        "status": "appReceive",
        "deviceInfo": homePageService.androidBoxInfo.value,
        "message": {
          "pH1": "${homePageService.pH1.value}",
          "bod": "${homePageService.bod.value}",
          "cod": "${homePageService.cod.value}",
          "tss": "${homePageService.tss.value}",
          "pH2": "${homePageService.pH2.value}",
          "pH3": "${homePageService.pH3.value}",
          "temp": "${homePageService.temp1.value}",
        }
      }));

      client!.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    }
  }

  publishMqttToCheckOnline() async {
    if (enablePubMqtt.value == "false") {
      final builder = MqttClientPayloadBuilder();
      builder.addString(json.encode({
        "status": "appReceive",
        "deviceInfo": homePageService.androidBoxInfo.value,
        "message": {}
      }));
      getClient().publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    }
  }

  void onDisconnected() {}

  void onConnected() {}

  void onSubscribed(String topic) {}
  void pong() {}

  // void startRequest({int delay = 20, String title = ''}) {
  //   if (timer1 != null) timer1!.cancel();
  //   timer1 = Timer(Duration(seconds: delay), () {
  //     showNotification(title: title);
  //   });
  // }

  // void endRequest() {
  //   if (timer1 != null) timer1!.cancel();
  // }
}
