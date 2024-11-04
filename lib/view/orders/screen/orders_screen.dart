import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/model/orders_model.dart';
import 'package:flutteradv6/view/orders/controller/orders_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OrdersController(),
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getAllOrders,
        child: Scaffold(
          backgroundColor: ColorsManager.primaryColor,
          appBar: AppBar(
            backgroundColor: ColorsManager.primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Messages.onWillPop(context),
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: controller.allOrders.data.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.w,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final thisItem = controller.allOrders.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: orderitem(thisItem),
                    );
                  },
                  itemCount: controller.allOrders.data.length,
                )
              : const Center(child: Text('nothing to show')),
        ),
      ),
    );
  }
}

Widget orderitem(OrderDetails order) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 6)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Image.asset(
            AppImages.tshirt,
            height: 12.h,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BEST SELLER',
                  style: TextStyle(color: Colors.green, fontSize: 14.sp),
                ),
                Text(
                  order.peoduct.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${order.peoduct.price.toString()}",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
