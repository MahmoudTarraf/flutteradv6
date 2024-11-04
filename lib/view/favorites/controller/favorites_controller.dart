import 'package:flutteradv6/core/service/database_service.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final DatabaseService _databaseService = DatabaseService.instance;
  var favoritesList = <ProductDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites(); // Load favorites when controller is initialized
  }

  Future<void> loadFavorites() async {
    final List<ProductDetails> favorites =
        await _databaseService.getFavorites();
    favoritesList.assignAll(favorites);
  }

  Future<void> updateFavoriteStatus(ProductDetails product) async {
    // Check if the product exists in favorites
    final isFavorite =
        favoritesList.any((favorite) => favorite.id == product.id);
    if (isFavorite) {
      await _databaseService.deleteFavorite(product.id);
      favoritesList.removeWhere((favorite) => favorite.id == product.id);
    } else {
      await _databaseService.addFavorite(product);
      favoritesList.add(product);
    }
    update(); // Notify listeners
  }
}
