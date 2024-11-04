import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:flutteradv6/view/cart/controller/cart_controller.dart';
import 'package:flutteradv6/view/orders/screen/orders_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Spacer(),
                    const Text(
                      "My Cart",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ),
              // Item Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${controller.cartItems.length} items",
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              // Cart Items
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final thisItem = controller.cartItems[index];
                    return CartItemWidget(
                      thisProduct: thisItem,
                      deleteProduct: controller.deleteProduct,
                      dereaseCount: controller.decreaseProductCount,
                      increaseCount: controller.increaseProductCount,
                    );
                  },
                  itemCount: controller.cartItems.length,
                ),
              ),

              // Summary
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    SummaryRow(label: 'Subtotal', amount: controller.sum),
                    const SummaryRow(label: 'Delivery', amount: 0),
                    const Divider(),
                    SummaryRow(
                      label: 'Total Cost',
                      amount: controller.sum,
                      highlight: true,
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.placeOrder().then(
                              (value) => Get.to(
                                () => const OrdersScreen(),
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: controller.statusRequest == StatusRequest.loading
                          ? const CircularProgressIndicator(
                              color: ColorsManager.white,
                            )
                          : Text(
                              'Checkout',
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final ProductDetails thisProduct;
  final Function increaseCount;
  final Function dereaseCount;
  final Function deleteProduct;

  const CartItemWidget({
    super.key,
    required this.thisProduct,
    required this.deleteProduct,
    required this.dereaseCount,
    required this.increaseCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Slidable(
        // Left side action: two buttons for quantity adjustment
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.5, // Adjust this ratio to fit both buttons
          children: [
            SlidableAction(
              onPressed: (context) => dereaseCount(thisProduct),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.remove,
              label: 'Decrease',
            ),
            SlidableAction(
              onPressed: (context) => increaseCount(thisProduct),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.add,
              label: 'Increase',
            ),
          ],
        ),

        // Right side action: delete button
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) => deleteProduct(thisProduct),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // Product item details
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Product Image
              Image.asset(
                AppImages.tshirt,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 1.h),

              // Item Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thisProduct.name,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '\$${thisProduct.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              // Quantity Controls (hidden within the Slidable actions)
              Text(
                '${thisProduct.count}',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool highlight;

  const SummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
