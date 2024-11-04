import 'package:flutter/material.dart';
import 'package:flutteradv6/core/const_data/my_size.dart';

class AppStrings {
  static const String tasksTableName = "favorites",
      favoritesIdColumnName = "id",
      favoritesTitleColumnName = "name",
      favoritesImageColumnName = "image",
      favoritesPriceColumnName = "price";
  static const darkModeString = Text(
    "Dark Mode",
    style: TextStyle(
      fontSize: MySize.fontSizeLg,
    ),
  );
  static const lightModeString = Text(
    "Light Mode",
    style: TextStyle(
      fontSize: MySize.fontSizeLg,
    ),
  );
}
