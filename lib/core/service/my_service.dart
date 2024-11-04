import 'package:flutteradv6/core/const_data/const_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_prefrences_keys.dart';

class MyService extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (await getStringData(SharedPrefrencesKeys.accessToken) != null) {
      ConstData.token = await getStringData(SharedPrefrencesKeys.accessToken);
    }
    return this;
  }

  Future<void> storeIsLogin(bool val) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(SharedPrefrencesKeys.isLoginKey, val);
  }

  Future<void> storeStringData(String key, String val) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, val);
  }

  Future<bool?> getIsLoginKey() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(SharedPrefrencesKeys.isLoginKey);
  }

  Future<String?> getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }

  Future<void> setConstantData() async {
    ConstData.token = await getStringData(SharedPrefrencesKeys.accessToken);
  }
}

Future<void> initialService() async {
  await Get.putAsync(() => MyService().init());
}
