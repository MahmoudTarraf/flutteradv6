import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:flutteradv6/view/cart/controller/cart_controller.dart';
import 'package:flutteradv6/view/cart/screen/cart_screen.dart';
import 'package:flutteradv6/view/products/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.thisProduct});
  final ProductDetails thisProduct;
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    final cartController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'T-shirt Shop',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          GetBuilder(
            init: CartController(),
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
                    onPressed: () => Get.to(
                      () => const CartScreen(),
                    ),
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
      body: GetBuilder(
        init: ProductsController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            //physics: const NeverScrollableScrollPhysics(),
            children: [
              // Product Title and Price
              Text(
                thisProduct.name,
                style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "${thisProduct.subCategory.name} ${thisProduct.subCategory.category.name}",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 2.h),
              Text(
                "\$ ${thisProduct.price.toString()}",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),
              SizedBox(height: 2.h),

              // Product Image Carousel (Use PageView or similar widget for multiple images)
              Center(
                child: Image.asset(
                  AppImages.tshirt,
                  height: 30.h,
                ),
                // CachedNetworkImage(
                //   imageUrl: "${AppLink.appRoot}${thisProduct.image}",
                //   fit: BoxFit.cover,
                //   placeholder: (context, url) => Image.asset(
                //     AppImages.placeHolder,
                //     height: 10.h,
                //   ),
                //   errorWidget: (context, url, error) => Image.asset(
                //     AppImages.tshirt,
                //     height: 30.h,
                //   ),
                // ),
              ),
              SizedBox(height: 2.h),

              // Thumbnail Selector for different styles/colors
              SizedBox(
                height: 20.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // replace with actual number of thumbnails
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        AppImages.tshirt, // Replace with actual image paths
                        width: 60,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h),

              // Product Description
              Text(
                'Programming And Software Engineering Are Your Passion? '
                'Then This Is Made For You As A Developer. Perfect Surprise '
                'For Any Programmer, Software Engineer, Developer, Coder, '
                'Computer Nerd Out There....',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              ),
              GestureDetector(
                onTap: () {},
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Read More',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.conversationColor,
                    ),
                    child: IconButton(
                      icon: thisProduct.isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        controller.updateFavorite(
                          thisProduct,
                        );
                      },
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final cartController = Get.find<CartController>();
                      cartController.addProduct(thisProduct);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.shopping_bag, color: Colors.white),
                    label: const Text(
                      'Add To Cart',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
