import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/text_styles.dart';
import 'package:flutteradv6/view/notifications/notifications_widgets/notification_appbar.dart';
import 'package:flutteradv6/view/notifications/notifications_widgets/notifications_leading_icons.dart';
import 'package:flutteradv6/view/notifications/notifications_widgets/row_creator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: const NotificationAppBar(
        icon: Icons.arrow_back_ios,
        title: "Notifications",
        backGroundColor: ColorsManager.primaryColor,
      ),
      body: GetBuilder(
        init: NotificationsController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                rowCreator(
                  () {},
                  "Today",
                  "Mark all as read",
                  MainAxisAlignment.spaceBetween,
                  ColorsManager.primary,
                ),
                SizedBox(
                  height: 87.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return notificationBuilder(
                        "Order Confirmed",
                        "Your order #12345 has been confirmed.",
                        false,
                        customerSupport(),
                      );
                    },
                    itemCount: 2,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget notificationBuilder(
  String title,
  String subTitle,
  bool isRead,
  Widget leadingIcon,
) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: ListTile(
      tileColor: ColorsManager.scaffoldBackgroundColor,
      leading: leadingIcon,
      title: Text(
        title,
        style: TextStyles.bodyTextStyle(
          fontSize: 17.sp,
          color: ColorsManager.black,
          fontWight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyles.bodyTextStyle(
          fontSize: 16.sp,
          color: ColorsManager.grey,
          fontWight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.circle,
        size: 15,
        color: isRead ? ColorsManager.grey : ColorsManager.primary,
      ),
    ),
  );
}
