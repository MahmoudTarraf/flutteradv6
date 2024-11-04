// To parse this JSON data, do
//
//     final ordersmodel = ordersmodelFromJson(jsonString);

import 'dart:convert';

Ordersmodel ordersmodelFromJson(String str) =>
    Ordersmodel.fromJson(json.decode(str));

String ordersmodelToJson(Ordersmodel data) => json.encode(data.toJson());

class Ordersmodel {
  final List<OrderDetails> data;
  final String message;

  Ordersmodel({
    required this.data,
    required this.message,
  });

  factory Ordersmodel.fromJson(Map<String, dynamic> json) => Ordersmodel(
        data: List<OrderDetails>.from(
            json["data"].map((x) => OrderDetails.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class OrderDetails {
  final int id;
  final Peoduct peoduct;
  final User user;
  final int quantity;

  OrderDetails({
    required this.id,
    required this.peoduct,
    required this.user,
    required this.quantity,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: json["id"],
        peoduct: Peoduct.fromJson(json["peoduct"]),
        user: User.fromJson(json["user"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "peoduct": peoduct.toJson(),
        "user": user.toJson(),
        "quantity": quantity,
      };
}

class Peoduct {
  final int id;
  final String name;
  final SubCategory subCategory;
  final String image;
  final int price;
  final int evaluation;
  final int discount;

  Peoduct({
    required this.id,
    required this.name,
    required this.subCategory,
    required this.image,
    required this.price,
    required this.evaluation,
    required this.discount,
  });

  factory Peoduct.fromJson(Map<String, dynamic> json) => Peoduct(
        id: json["id"],
        name: json["name"],
        subCategory: SubCategory.fromJson(json["sub-category"]),
        image: json["image"],
        price: json["price"],
        evaluation: json["evaluation"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub-category": subCategory.toJson(),
        "image": image,
        "price": price,
        "evaluation": evaluation,
        "discount": discount,
      };
}

class SubCategory {
  final int id;
  final String name;
  final User category;

  SubCategory({
    required this.id,
    required this.name,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        category: User.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category.toJson(),
      };
}

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
