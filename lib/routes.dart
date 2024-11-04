import 'package:flutteradv6/model/products_model.dart';
import 'package:flutteradv6/view/auth/login/screen/login_screen.dart';
import 'package:flutteradv6/view/auth/register/screen/register_screen.dart';
import 'package:flutteradv6/view/home/screen/home_screen.dart';
import 'package:flutteradv6/view/product_details/screen/product_details_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: '/homeScreen',
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: '/registerScreen',
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: '/loginScreen',
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: '/productDetailsScreen',
    page: () => ProductDetailScreen(
      thisProduct: thatProduct,
    ),
  ),
];
