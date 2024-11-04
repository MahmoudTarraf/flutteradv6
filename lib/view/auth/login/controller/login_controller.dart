// controllers/login_controller.dart
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutteradv6/core/class/crud.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_link.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/core/service/my_service.dart';
import 'package:flutteradv6/core/service/routes.dart';
import 'package:flutteradv6/core/service/shared_prefrences_keys.dart';
import 'package:flutteradv6/model/user_model.dart';
import 'package:flutteradv6/view/profile/controller/user_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false;
  StatusRequest statusRequest = StatusRequest.none;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void login() async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Basic validation for empty fields
      if (email.isEmpty || password.isEmpty) {
        Messages.getSnackMessage(
            "Error", "Please fill in all fields", ColorsManager.primary, 3);
        return;
      }

      final fcmToken = await fcm.getToken() ?? "";

      Map<String, String> fields = {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      };

      statusRequest = StatusRequest.loading;
      update();

      final result = await Crud().postData(
        AppLink.login,
        fields,
        AppLink().getHeader(),
        true,
        isFormData: true,
      );

      // Handling response
      result.fold(
        (error) {
          statusRequest = error; // Update with success status

          // Error handling
          Messages.getSnackMessage(
              "Error", error.toString(), ColorsManager.primary, 3);
        },
        (responseBody) async {
          statusRequest = StatusRequest.success; // Update with success status

          // Success handling
          final userModel = userModelFromJson(jsonEncode(responseBody));
          final myService = Get.find<MyService>();
          Get.find<UserService>().setUser(userModel);

          // Save access token and login status
          await myService.storeStringData(
            SharedPrefrencesKeys.accessToken,
            Get.find<UserService>().currentUser!.data.accessToken,
          );
          await myService.storeIsLogin(true);

          Messages.getSnackMessage(
            responseBody['message'],
            'Login To Your Account!',
            ColorsManager.green,
            3,
          );
          Get.offAllNamed(Routes.homeScreen);
        },
      );
    } catch (e) {
      statusRequest = StatusRequest.serverFailure; // Update with success status

      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    } finally {
      statusRequest = StatusRequest.none; // Update with success status
      update();
    }
  }

  void signInWithGoogle() {
    Messages.getSnackMessage(
        'Login', "Google Login Coming soon!", ColorsManager.cartColor, 3);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
