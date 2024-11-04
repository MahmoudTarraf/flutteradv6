import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_link.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/core/service/my_service.dart';
import 'package:flutteradv6/core/service/routes.dart';
import 'package:flutteradv6/core/service/shared_prefrences_keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SideMenuController extends GetxController {
  logout() async {
    bool shouldExit = false;
    await Get.defaultDialog(
      backgroundColor: ColorsManager.white,
      buttonColor: ColorsManager.primary,
      title: "Logout???",
      middleText: "Are you sure you want to leave?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: ColorsManager.white,
      onCancel: () {
        shouldExit = false; // Don't exit the app
        Get.back();
      },
      onConfirm: () {
        shouldExit = true; // Set to true to signal app exit
        Get.back();
      },
    );
    if (shouldExit == false) {
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(AppLink.logout),
        headers: AppLink().getHeaderToken(),
      );
      if (response.statusCode == 200) {
        await MyService().storeIsLogin(false);
        await MyService().storeStringData(SharedPrefrencesKeys.accessToken, '');
        Get.offAllNamed(Routes.registerScreen);
      } else {
        Messages.getSnackMessage(
            'Error', response.body, ColorsManager.primary, 3);
      }
    } catch (e) {
      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    }
  }
}
