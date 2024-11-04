import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const_data/app_colors.dart';

class Messages {
  static getSnackMessage(
      String title, String subTitle, Color backColor, int seconds) {
    Get.snackbar(
      title,
      subTitle,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backColor,
      colorText: ColorsManager.white,
      duration: Duration(
        seconds: seconds,
      ),
    );
  }

  static Future<bool> onWillPop(BuildContext context) async {
    // Check if there's a page to pop back to
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return Future.value(false); // Prevent app exit
    }

    // If no previous page exists, show the exit confirmation dialog
    bool shouldExit = false; // Variable to track if the app should close

    await Get.defaultDialog(
      backgroundColor: ColorsManager.white,
      buttonColor: ColorsManager.primary,
      title: "Exit App",
      middleText: "Are you sure you want to leave?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onCancel: () {
        shouldExit = false; // Don't exit the app
        Get.back(); // Close the dialog
      },
      onConfirm: () {
        shouldExit = true; // Set to true to signal app exit
        Get.back(); // Close the dialog
      },
    );

    return shouldExit; // Return true if the user confirmed to exit
  }
}
