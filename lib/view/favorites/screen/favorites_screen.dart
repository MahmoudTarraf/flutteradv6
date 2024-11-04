import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/const_data/app_images.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:flutteradv6/view/favorites/controller/favorites_controller.dart';
import 'package:flutteradv6/view/product_details/screen/product_details_screen.dart';
import 'package:flutteradv6/view/products/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Messages.onWillPop(context),
        ),
        title: Text(
          'Favourite',
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
      body: GetBuilder(
        init: FavoritesController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemCount: controller.favoritesList
                .length, // replace with actual count of favorite items
            itemBuilder: (context, index) {
              final thisFavoriteItem = controller.favoritesList[index];
              return InkWell(
                onTap: () => Get.to(
                  () => ProductDetailScreen(
                    thisProduct: thisFavoriteItem,
                  ),
                ),
                child: _buildFavoriteItem(
                  thisFavoriteItem: thisFavoriteItem,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteItem({
    required ProductDetails thisFavoriteItem,
  }) {
    final dbsContoller = Get.put(ProductsController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heart Icon and Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      AppImages.tshirt,
                      height: 20.h,
                    )
                    //  CachedNetworkImage(
                    //   imageUrl: "${AppLink.appRoot}${thisFavoriteItem.image}",
                    //   fit: BoxFit.cover,
                    //   placeholder: (context, url) => Image.asset(
                    //     AppImages.placeHolder,
                    //     height: 10.h,
                    //   ),
                    //   errorWidget: (context, url, error) => Image.asset(
                    //     AppImages.tshirt,
                    //     height: 20.h,
                    //   ),
                    // ),
                    ),
              ),
              Positioned(
                left: 8,
                top: 2,
                child: IconButton(
                  icon: thisFavoriteItem.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.black,
                        ),
                  onPressed: () {
                    dbsContoller.updateFavorite(
                      thisFavoriteItem,
                    );
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
                Text(
                  'BEST SELLER',
                  style: TextStyle(color: Colors.green, fontSize: 14.sp),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    thisFavoriteItem.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${thisFavoriteItem.price.toString()}",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Row(
                      children: [
                        _buildColorDot(Colors.red),
                        SizedBox(width: 2.w),
                        _buildColorDot(Colors.blue),
                        SizedBox(width: 2.w),
                        _buildColorDot(Colors.black),
                      ],
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

  Widget _buildColorDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
