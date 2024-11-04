import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/const_data/text_styles.dart';

class NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationAppBar({
    super.key,
    required this.icon,
    required this.title,
    required this.backGroundColor,
  });
  final IconData? icon;
  final Color backGroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading:
            false, // This disables the default back button
        backgroundColor: backGroundColor,
        leading: IconButton(
          icon: Icon(
            icon,
            color: ColorsManager.primary, // Customize the color of the icon
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.appBarTextStyle(
                color: Colors.black,
                fontSize: 22,
                isBold: true,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorsManager.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "2 New",
                style: TextStyles.bodyTextStyle(
                  fontSize: 17.sp,
                  color: ColorsManager.white,
                  fontWight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
