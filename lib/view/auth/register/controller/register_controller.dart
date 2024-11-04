// controllers/register_controller.dart

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutteradv6/core/class/crud.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_link.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/core/service/routes.dart';
import 'package:flutteradv6/model/user_model.dart';
import 'package:flutteradv6/view/profile/controller/user_service.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false;
  StatusRequest statusRequest = StatusRequest.none;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void register() async {
    try {
      // Collecting and validating input data
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        Messages.getSnackMessage(
            "Error", "Please fill in all fields", ColorsManager.primary, 3);
        return;
      }

      final fcmToken = await fcm.getToken() ?? "";

      // Prepare form-data fields to send
      Map<String, String> fields = {
        'name': name,
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      };

      statusRequest = StatusRequest.loading;
      update();

      final result = await Crud().postData(
        AppLink.register,
        fields,
        AppLink().getHeader(),
        true,
        isFormData: true,
      );

      // Handling response
      result.fold(
        (error) {
          statusRequest = error; // Update with error status

          Messages.getSnackMessage(
              "Error", error.toString(), ColorsManager.primary, 3);
        },
        (responseBody) async {
          statusRequest = StatusRequest.success; // Update with success status

          final userModel = userModelFromJson(jsonEncode(responseBody));
          Get.find<UserService>().setUser(userModel);

          Messages.getSnackMessage(responseBody['message'],
              'Login To Your Account!', ColorsManager.green, 3);
          Get.toNamed(Routes.loginScreen);
        },
      );
    } catch (e) {
      statusRequest = StatusRequest.serverFailure; // General failure status

      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    } finally {
      statusRequest = StatusRequest.none; // General failure status
      update();
    }
  }

  void signUpWithGoogle() {
    Messages.getSnackMessage(
        'Register', "Google Register Coming soon!", ColorsManager.cartColor, 3);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
