// screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/view/auth/register/controller/register_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutteradv6/core/service/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
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
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Register Account',
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
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Name Field
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        hintText: 'xxxxxxx',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Email Field
                    TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        hintText: 'xyz@gmail.com',
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
                          icon: Icon(
                            controller.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: controller.register,
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: ColorsManager.white,
                              ),
                            ),
                    ),
                    SizedBox(height: 2.h),

                    // Google Sign Up Button
                    OutlinedButton.icon(
                      onPressed: controller.signUpWithGoogle,
                      icon: Image.asset(
                        AppImages.googleIcon,
                        height: 3.h,
                        width: 10.w,
                      ),
                      label: const Text(
                        'Sign Up With Google',
                        style: TextStyle(fontSize: 18),
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
                    SizedBox(height: 4.h),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have Account?'),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.loginScreen);
                          },
                          child: Text(
                            'Log In',
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
