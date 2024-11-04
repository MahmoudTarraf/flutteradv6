import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/view/cart/screen/cart_screen.dart';
import 'package:flutteradv6/view/favorites/screen/favorites_screen.dart';
import 'package:flutteradv6/view/notifications/screen/notifications_screen.dart';
import 'package:flutteradv6/view/profile/screen/profile_screen.dart';
import 'package:flutteradv6/view/orders/screen/orders_screen.dart';
import 'package:flutteradv6/view/side_menu/controller/side_menu_controller.dart';
import 'package:get/get.dart';

class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87, // Set background color for the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black87, // Background color for header
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      AppImages.tshirt,
                    ), // Replace with actual image URL
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Programmer X',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            itemCreator(
              Icons.person_outline,
              "Profile",
              () => Get.to(() => const ProfileScreen()),
            ),
            itemCreator(
              Icons.shopping_bag_outlined,
              "My Cart",
              () => Get.to(() => const CartScreen()),
            ),
            itemCreator(
              Icons.favorite_outline,
              "Favorite",
              () => Get.to(() => const FavoritesScreen()),
            ),
            itemCreator(
              Icons.local_shipping_outlined,
              "Orders",
              () => Get.to(() => const OrdersScreen()),
            ),
            itemCreator(
              Icons.notifications_outlined,
              "Notifications",
              () => Get.to(
                () => const NotificationsScreen(),
              ),
            ),
            itemCreator(Icons.settings_outlined, "Settings", () {
              Messages.getSnackMessage(
                'Soon',
                'Working On Settings!',
                ColorsManager.cartColor,
                2,
              );
            }),

            const Divider(color: Colors.white54), // Divider for separation
            itemCreator(Icons.logout, "Sign Out", () {
              Get.put(SideMenuController());
              final controller = Get.find<SideMenuController>();
              controller.logout();
            }),
          ],
        ),
      ),
    );
  }
}

Widget itemCreator(
    IconData leadingIconData, String title, void Function()? onTap) {
  return ListTile(
    leading: Icon(leadingIconData, color: Colors.white),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    trailing: const Icon(Icons.chevron_right, color: Colors.white),
    onTap: onTap,
  );
}
