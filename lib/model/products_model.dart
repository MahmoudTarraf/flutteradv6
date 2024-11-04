// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  final List<ProductDetails> data;
  final String message;

  ProductsModel({
    required this.data,
    required this.message,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        data: List<ProductDetails>.from(
            json["data"].map((x) => ProductDetails.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ProductDetails {
  final int id;
  final String name;
  final SubCategory subCategory;
  final String image;
  final int price;
  final int evaluation;
  final int discount;
  int count;
  bool isFavorite;
  ProductDetails({
    required this.id,
    required this.name,
    required this.subCategory,
    required this.image,
    required this.price,
    required this.evaluation,
    required this.discount,
    required this.isFavorite,
    this.count = 1,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        name: json["name"],
        subCategory: SubCategory.fromJson(json["sub-category"]),
        image: json["image"],
        price: json["price"],
        evaluation: json["evaluation"],
        discount: json["discount"],
        isFavorite: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub-category": subCategory.toJson(),
        "image": image,
        "price": price,
        "evaluation": evaluation,
        "discount": discount,
        "isFavorite": isFavorite,
      };
}

class SubCategory {
  final int id;
  final String name;
  final Category category;

  SubCategory({
    required this.id,
    required this.name,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category.toJson(),
      };
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

final thatProduct = ProductDetails(
    discount: 0,
    evaluation: 0,
    id: 0,
    image: '',
    isFavorite: false,
    name: '',
    price: 0,
    subCategory:
        SubCategory(id: 0, name: '', category: Category(id: 0, name: '')));
