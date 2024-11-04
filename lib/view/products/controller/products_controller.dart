import 'dart:convert';

import 'package:flutteradv6/core/class/crud.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_link.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/core/service/database_service.dart';
import 'package:flutteradv6/core/service/my_service.dart';
import 'package:flutteradv6/model/category_model.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:flutteradv6/view/favorites/controller/favorites_controller.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  bool productsLoaded = false;
  StatusRequest statusRequestCategories = StatusRequest.none;
  StatusRequest statusRequestProducts = StatusRequest.none;

  CategoryModel categories = CategoryModel(data: [], message: '');
  ProductsModel products = ProductsModel(data: [], message: '');
  final DatabaseService _databaseService = DatabaseService.instance;
  final favoriteController = Get.put(FavoritesController());
  final myService = Get.find<MyService>();
  @override
  void onInit() {
    super.onInit();
    if (!productsLoaded) {
      getAllProducts();
      getAllCategories();
      productsLoaded = true; // Mark as loaded after the initial fetch
    }
  }

  Future<void> getAllCategories() async {
    try {
      statusRequestCategories = StatusRequest.loading;
      update();
      final result = await Crud().getData(
        AppLink.allCategories,
      );

      result.fold(
        (error) {
          statusRequestCategories = error;
          Messages.getSnackMessage(
              "Error", error.toString(), ColorsManager.primary, 3);
        },
        (responseBody) {
          statusRequestCategories = StatusRequest.success;
          categories = CategoryModel.fromJson(responseBody);
          update(); // Update the UI
        },
      );
    } catch (e) {
      statusRequestCategories = StatusRequest.serverFailure;
      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    } finally {
      statusRequestCategories = StatusRequest.none;
      update();
    }
  }

  Future<void> getAllProducts() async {
    try {
      statusRequestProducts = StatusRequest.loading;
      update();

      // Use the Crud class to get data
      final result = await Crud().getData(AppLink.allProducts);

      result.fold(
        (error) {
          statusRequestProducts = error;
          Messages.getSnackMessage(
              "Error", error.toString(), ColorsManager.primary, 3);
        },
        (responseBody) async {
          statusRequestProducts = StatusRequest.success;

          String jsonString = json.encode(responseBody);

          products = productsModelFromJson(jsonString);

          final existingFavorites = await _databaseService.getFavorites();
          for (ProductDetails item in products.data) {
            if (existingFavorites.any((element) => element.name == item.name)) {
              item.isFavorite = true;
            }
          }
          update(); // Update the UI
        },
      );
    } catch (e) {
      statusRequestProducts = StatusRequest.serverFailure;
      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    } finally {
      statusRequestProducts = StatusRequest.none;
      update();
    }
  }

  void updateFavorite(ProductDetails thisProduct) async {
    // Check if the product already exists in the favorites
    final existingFavorites = await _databaseService.getFavorites();
    final isProductInFavorites =
        existingFavorites.any((favorite) => favorite.id == thisProduct.id);

    if (!isProductInFavorites) {
      // If adding and product is not in favorites, add it
      thisProduct.isFavorite = true; // Set as favorite
      await _databaseService.addFavorite(thisProduct); // Add to database
      Messages.getSnackMessage('Done!',
          "Added ${thisProduct.name} To Favorites", ColorsManager.green, 1);
    } else {
      // If removing and product is in favorites, delete it
      thisProduct.isFavorite = false; // Set as not favorite
      await _databaseService
          .deleteFavorite(thisProduct.id); // Remove from database
      Messages.getSnackMessage(
          'Done!',
          "Removed ${thisProduct.name} From Favorites",
          ColorsManager.primary,
          1);
    }
    await favoriteController.updateFavoriteStatus(thisProduct);
    favoriteController.loadFavorites();
    update(); // Notify listeners to rebuild the UI
  }

  Future<void> onRefresh() async {
    await getAllCategories();
    await getAllProducts();
  }
}
