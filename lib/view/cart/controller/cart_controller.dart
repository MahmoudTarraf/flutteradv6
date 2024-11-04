import 'package:flutteradv6/core/class/crud.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_link.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/model/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<ProductDetails> cartItems = [];
  StatusRequest statusRequest = StatusRequest.none;
  double sum = 0.0;
  addProduct(ProductDetails p) {
    var existingProduct = cartItems.firstWhere(
      (product) => product.name == p.name,
      orElse: () => thatProduct,
    );

    if (existingProduct != thatProduct) {
      existingProduct.count += 1;
    } else {
      cartItems.add(p);
    }
    calculateSumCart();
    Get.showSnackbar(const GetSnackBar(
      duration: Duration(seconds: 1),
      message: 'Added Product Successfully!',
      backgroundColor: ColorsManager.green,
    ));
    update();
  }

  void deleteProduct(ProductDetails p) {
    p.count = 1;
    cartItems.removeWhere((product) => product.name == p.name);
    calculateSumCart();
    update();
  }

  increaseProductCount(ProductDetails p) {
    for (var product in cartItems) {
      if (product.name == p.name) {
        product.count += 1;
      }
    }
    calculateSumCart();
    update();
  }

  decreaseProductCount(ProductDetails p) {
    for (var product in cartItems) {
      if (product.name == p.name) {
        if (product.count > 1) {
          product.count -= 1;
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              message:
                  ('You cannot decrease the count further, To delete swipe from right to left.'),
              duration: Duration(seconds: 1),
              backgroundColor: ColorsManager.cartColor,
            ),
          );
        }
      }
    }
    calculateSumCart();
    update();
  }

  calculateSumCart() {
    sum = 0.0;
    for (var product in cartItems) {
      sum += product.price * product.count;
    }
    update();
  }

  Future<void> placeOrder() async {
    if (cartItems.isEmpty) {
      Messages.getSnackMessage(
          'Error', 'No items in cart!', ColorsManager.primary, 3);
      return;
    }

    try {
      statusRequest = StatusRequest.loading;
      update();

      for (var product in cartItems) {
        // Prepare form-data fields for each product
        Map<String, String> fields = {
          'product_id': product.id.toString(),
          'quantity': product.count.toString(),
        };
        final result = await Crud().postData(
          AppLink.orders,
          fields,
          AppLink().getHeaderToken(),
          false,
          isFormData: true,
        );

        result.fold(
          (error) {
            statusRequest = error;
            Messages.getSnackMessage(
                "Error", error.toString(), ColorsManager.primary, 3);
          },
          (responseBody) {
            statusRequest = StatusRequest.success;
            Messages.getSnackMessage(
                'Message', responseBody['message'], ColorsManager.green, 3);
          },
        );
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    } finally {
      statusRequest = StatusRequest.none;
      update();
    }
  }
}
