import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/app_colors.dart';

Widget rowCreator(
  void Function()? onPressed,
  String title, [
  String subtitle = 'See All',
  MainAxisAlignment val = MainAxisAlignment.spaceAround,
  Color subTitleColor = Colors.purple,
]) {
  return Row(
    mainAxisAlignment: val,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          title,
          style: const TextStyle(
            color: ColorsManager.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: subTitleColor,
        ),
        onPressed: onPressed,
        child: Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.underline,
            decorationColor: subTitleColor,
          ),
        ),
      ),
    ],
  );
}
