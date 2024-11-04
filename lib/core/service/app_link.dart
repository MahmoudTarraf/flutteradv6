//this file for the API

import 'package:flutteradv6/core/const_data/const_data.dart';

class AppLink {
  // Remote link
  static String appRoot = "http://task.focal-x.com/api";
  static String allCategories = "$appRoot/categories";
  static String allProducts = "$appRoot/products";
  static String register = "$appRoot/register";
  static String login = "$appRoot/login";
  static String orders = "$appRoot/orders";
  static String logout = "$appRoot/logout";

  static String localLink = "http://127.0.0.1:8000/";
  // Token link

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      //'content-type': 'application/json',
      'Accept': 'application/json',
    };
    return mainHeader;
  }

  Map<String, String> getHeaderToken() {
    Map<String, String> mainHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ConstData.token}'
    };
    return mainHeader;
  }
}
