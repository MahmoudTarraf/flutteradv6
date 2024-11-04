import 'package:flutter/material.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:flutteradv6/view/cart/controller/cart_controller.dart';
import 'package:flutteradv6/view/cart/screen/cart_screen.dart';
import 'package:flutteradv6/view/product_details/screen/product_details_screen.dart';
import 'package:flutteradv6/view/products/controller/products_controller.dart';
import 'package:flutteradv6/view/side_menu/screen/side_menu_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    final cartController = Get.find<CartController>();
    Get.put(ProductsController(), permanent: true);

    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      drawer: const SideMenuScreen(),
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Image.asset(AppImages.menu)),
        title: Image.asset(
          AppImages.explore,
        ),
        actions: [
          GetBuilder<CartController>(
            builder: (controller) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 5),
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: ColorsManager.white,
                      padding: const EdgeInsets.all(15),
                    ),
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: ColorsManager.black,
                      size: 30,
                    ),
                    onPressed: () => Get.to(() => const CartScreen()),
                  ),
                ),
                if (cartController.cartItems.isNotEmpty)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      height: 3.h,
                      width: 3.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: GetBuilder<ProductsController>(
        builder: (controller) {
          // UI based on the statusRequest
          if (controller.statusRequestProducts == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.statusRequestProducts ==
                  StatusRequest.serverFailure ||
              controller.statusRequestProducts == StatusRequest.failure ||
              controller.statusRequestProducts ==
                  StatusRequest.offlineFailure) {
            return const Center(child: Text('Failed to load products.'));
          } else if (controller.products.data.isEmpty) {
            return const Center(child: Text('No Products!'));
          }

          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar and Filter Button
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Looking for...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.h),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsManager.green,
                          ),
                          child: const Icon(
                            Icons.tune_outlined,
                            color: ColorsManager.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    // Category Section
                    const Text(
                      'Select Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: controller.categories.data
                          .map((category) => _categoryButton(category.name))
                          .toList(),
                    ),
                    SizedBox(height: 2.h),

                    // Popular T-shirt Section
                    _sectionHeader('Popular T-shirt', onViewAll: () {}),
                    SizedBox(height: 2.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.products.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = controller.products.data[index];
                        return InkWell(
                          onTap: () => Get.to(
                              () => ProductDetailScreen(thisProduct: product)),
                          child: _productItem(product, controller),
                        );
                      },
                    ),
                    SizedBox(height: 2.h),

                    _sectionHeader('New Arrivals', onViewAll: () {}),
                    SizedBox(
                      height: 20.h,
                      width: double.infinity,
                      child: Image.asset(AppImages.arrival),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper Widgets
  Widget _categoryButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: ColorsManager.white,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: ColorsManager.black,
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: const Text(
            'See all',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _productItem(ProductDetails product, ProductsController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Image.asset(
                  AppImages.tshirt,
                  height: 15.h,
                ),
              ),
              Positioned(
                left: 8,
                top: 8,
                child: IconButton(
                  icon: product.isFavorite
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border_outlined,
                          color: Colors.black),
                  onPressed: () {
                    controller.updateFavorite(product);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BEST SELLER',
                    style: TextStyle(color: Colors.green, fontSize: 14.sp)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    product.name,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product.price.toString()}",
                        style: TextStyle(fontSize: 16.sp)),
                    InkWell(
                      onTap: () {
                        final CartController cartController =
                            Get.put(CartController());
                        cartController.addProduct(product);
                      },
                      child: Image.asset(AppImages.heart),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
