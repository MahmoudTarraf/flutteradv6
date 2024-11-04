import 'package:flutter/material.dart';

import '../../../core/const_data/app_colors.dart';

Widget orderConfirmedIcon() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: ColorsManager.orderConfirmedColor,
        borderRadius: BorderRadius.circular(5)),
    child: const Icon(
      Icons.check_circle,
      color: ColorsManager.green,
    ),
  );
}

Widget orderShippedIcon() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: ColorsManager.orderShippedColor,
        borderRadius: BorderRadius.circular(5)),
    child: const Icon(
      Icons.fire_truck,
      color: ColorsManager.blue,
    ),
  );
}

Widget outForDeliveryIcon() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorsManager.outForDelivery,
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Icon(
      Icons.pedal_bike_outlined,
      color: Colors.orange,
    ),
  );
}

Widget orderDelivered() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorsManager.orderDelivered,
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Icon(
      Icons.home,
      color: Colors.purple,
    ),
  );
}

Widget orderCanceled() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorsManager.orderCanceled,
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Icon(
      Icons.cancel,
      color: Colors.red,
    ),
  );
}

Widget paymentRecieved() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorsManager.orderShippedColor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Icon(
      Icons.payment,
      color: ColorsManager.blue,
    ),
  );
}

Widget orderUpdate() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorsManager.outForDelivery,
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Icon(
      Icons.update,
      color: Colors.orange,
    ),
  );
}

Widget customerSupport() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorsManager.customerSupport,
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Icon(
      Icons.support,
      color: Colors.brown,
    ),
  );
}
