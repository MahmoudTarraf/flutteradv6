import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';

class AppTheme {
  // light theme
  static final lightTheme = ThemeData(
    primaryColor: ColorsManager.lightThemeColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.white,
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
          (states) => ColorsManager.lightThemeColor),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.white,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorsManager.black,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: ColorsManager.lightThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: ColorsManager.lightThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: ColorsManager.darkThemeColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.black,
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>(
          (states) => ColorsManager.darkThemeColor),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.black,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorsManager.green,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: ColorsManager.darkThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: ColorsManager.darkThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );

  // colors
}
