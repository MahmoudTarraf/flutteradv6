// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/core/service/routes.dart';
import 'package:flutteradv6/view/auth/login/controller/login_controller.dart';
import 'package:flutteradv6/view/profile/controller/user_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Get.find<UserService>();
    String name = userService.currentUser?.data.user.name ?? "Again";
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back(); // Navigate back
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Title
                    Text(
                      'Hello $name!',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),

                    // Subtitle
                    Text(
                      'Fill Your Details Or Continue With Social Media',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),

                    // Email Field
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: userService.currentUser?.data.user.email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Password Field
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        suffixIcon: IconButton(
                          icon: Icon(controller.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),

                    // Recovery Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle password recovery
                        },
                        child: const Text(
                          'Recovery Password',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Sign In Button
                    ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: controller.statusRequest == StatusRequest.loading
                          ? const CircularProgressIndicator(
                              color: ColorsManager.white,
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: ColorsManager.white,
                              ),
                            ),
                    ),
                    SizedBox(height: 2.h),

                    // Google Sign In Button
                    OutlinedButton.icon(
                      onPressed: controller.signInWithGoogle,
                      icon: Image.asset(
                        AppImages
                            .googleIcon, // Replace with actual path to Google icon asset
                        height: 3.h,
                        width: 10.w,
                      ),
                      label: Text(
                        'Sign In With Google',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New User?'),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.registerScreen);
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: ColorsManager.black,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
