import 'dart:convert';

import 'package:flutteradv6/core/class/crud.dart';
import 'package:flutteradv6/core/class/status_request.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';
import 'package:flutteradv6/core/service/app_link.dart';
import 'package:flutteradv6/core/service/app_messages.dart';
import 'package:flutteradv6/model/orders_model.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  Ordersmodel allOrders = Ordersmodel(data: [], message: '');
  StatusRequest statusRequest = StatusRequest.none;

  Future<void> getAllOrders() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final result = await Crud().getData(
        AppLink.orders,
      );

      result.fold(
        (error) {
          statusRequest = error;

          Messages.getSnackMessage(
            "Error",
            error.toString(),
            ColorsManager.primary,
            3,
          );
        },
        (responseBody) {
          statusRequest = StatusRequest.success;
          String jsonString = json.encode(responseBody);

          allOrders = ordersmodelFromJson(jsonString);
          update();
        },
      );
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;

      Messages.getSnackMessage('Error', e.toString(), ColorsManager.primary, 3);
    } finally {
      statusRequest = StatusRequest.none;
      update();
    }
  }

  @override
  void onInit() {
    getAllOrders();
    super.onInit();
  }
}
