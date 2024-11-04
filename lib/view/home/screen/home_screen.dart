import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/view/favorites/screen/favorites_screen.dart';
import 'package:flutteradv6/view/home/controller/home_controller.dart';
import 'package:flutteradv6/view/notifications/screen/notifications_screen.dart';
import 'package:flutteradv6/view/products/screen/products_screen.dart';
import 'package:flutteradv6/view/profile/screen/profile_screen.dart';
import 'package:flutteradv6/view/side_menu/screen/side_menu_screen.dart';
import 'package:flutteradv6/view/orders/screen/orders_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Widget getWidgets(int index) {
    switch (index) {
      case 0:
        return const OrdersScreen();
      case 1:
        return const FavoritesScreen();
      case 2:
        return const ProductsScreen();
      case 3:
        return const NotificationsScreen();
      case 4:
        return const ProfileScreen();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => WillPopScope(
        onWillPop: () => Messages.onWillPop(context),
        child: Scaffold(
          drawer: const SideMenuScreen(),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: GetBuilder(
              init: HomeController(),
              builder: (controller) {
                return getWidgets(controller.selectedIndex);
              },
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            animationCurve: Curves.bounceIn,
            animationDuration: const Duration(seconds: 1),
            color: ColorsManager.white,
            height: 8.h,
            buttonBackgroundColor: ColorsManager.green,
            backgroundColor: ColorsManager.primaryColor,
            index: controller.selectedIndex,
            onTap: (int index) {
              controller.updateIndex(index);
            },
            items: [
              Icon(
                Icons.wallet_giftcard_outlined,
                color:
                    controller.selectedIndex == 0 ? Colors.white : Colors.black,
                size: controller.selectedIndex == 0 ? 32 : 24,
              ),
              Icon(
                Icons.favorite_border_outlined,
                color:
                    controller.selectedIndex == 1 ? Colors.white : Colors.black,
                size: controller.selectedIndex == 1 ? 32 : 24,
              ),
              Icon(
                Icons.home_outlined,
                color:
                    controller.selectedIndex == 2 ? Colors.white : Colors.black,
                size: controller.selectedIndex == 2 ? 32 : 24,
              ),
              Icon(
                Icons.notifications_none_outlined,
                color:
                    controller.selectedIndex == 3 ? Colors.white : Colors.black,
                size: controller.selectedIndex == 3 ? 32 : 24,
              ),
              Icon(
                Icons.person_outline_outlined,
                color:
                    controller.selectedIndex == 4 ? Colors.white : Colors.black,
                size: controller.selectedIndex == 4 ? 32 : 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
