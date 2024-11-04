import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteradv6/binding/initial_bindings.dart';
import 'package:flutteradv6/core/const_data/app_theme.dart';
import 'package:flutteradv6/core/service/my_service.dart';
import 'package:flutteradv6/core/service/routes.dart';
import 'package:flutteradv6/routes.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutteradv6/core/service/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await initialService();
  final initialRoute = await MyService().getIsLoginKey() == true
      ? Routes.homeScreen
      : Routes.registerScreen;
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.initialRoute,
  });
  final String? initialRoute;
  final mySerivce = Get.find<MyService>();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        initialBinding: InitialBindings(),
        debugShowCheckedModeBanner: false, // Removes the debug banner
        title: 'New App Store',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: initialRoute, // Initial route, adjust as needed
        getPages: routes, // Set up your app routes using GetX
      ),
    );
  }
}
