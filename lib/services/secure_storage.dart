import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/services/homepage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends GetxService {
  final storage = const FlutterSecureStorage();

  HomePageService homePageService = Get.put(HomePageService());

  /// ================ secure storage ==================**/

  //read/write data setup
  //pH1-----------------------------------------------
  //write
  Future<void> writeDataSetup(int i) async {
    List<dynamic> values = [
      homePageService.pHMinSet.value.toString(),
      homePageService.pHMaxSet.value.toString(),
      homePageService.codSet.value.toString(),
      homePageService.bodSet.value.toString(),
      homePageService.tssSet.value.toString(),
      homePageService.offsetpH1.value.toString(),
      homePageService.offsetpH2.value.toString(),
      homePageService.offsetpH3.value.toString(),
      homePageService.offsetCOD.value.toString(),
      homePageService.offsetTSS.value.toString(),
      homePageService.thietBiId.value,
    ];
    await storage.write(
      key: homePageService.keySetup[i],
      value: values[i],
      aOptions: _getAndroidOptions(),
    );
    readOneDataSetup(i);
  }

  //read
  Future<void> readDataSetup(int i) async {
    homePageService.mapSetup[homePageService.keySetup[i]] = (await storage.read(
      key: homePageService.keySetup[i],
      aOptions: _getAndroidOptions(),
    ))!;
  }

  //read one
  Future<void> readOneDataSetup(int k) async {
    homePageService.mapSetup[homePageService.keySetup[k]] = (await storage.read(
      key: homePageService.keySetup[k],
      aOptions: _getAndroidOptions(),
    ));
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
