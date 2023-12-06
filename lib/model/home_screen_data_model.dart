// To parse this JSON data, do
//     final homeScreenDataModel = homeScreenDataModelFromJson(jsonString);
import 'dart:convert';

HomeScreenDataModel homeScreenDataModelFromJson(String str) =>
    HomeScreenDataModel.fromJson(
      json.decode(str),
    );

String homeScreenDataModelToJson(HomeScreenDataModel data) => json.encode(
      data.toJson(),
    );

class HomeScreenDataModel {
  HomeScreenDataModel({
    required this.status,
    required this.data,
  });

  final int status;
  final Data data;

  factory HomeScreenDataModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenDataModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.categories,
    required this.allProduct,
  });

  final List<CategoryModel> categories;
  final List<AllProduct> allProduct;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<CategoryModel>.from(
          json["categories"].map(
            (x) => CategoryModel.fromJson(x),
          ),
        ),
        allProduct: List<AllProduct>.from(
          json["all_product"].map(
            (x) => AllProduct.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(
          categories.map(
            (x) => x.toJson(),
          ),
        ),
        "all_product": List<dynamic>.from(
          allProduct.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class AllProduct {
  AllProduct({
    required this.image,
    required this.productName,
    required this.price,
    required this.hours,
    required this.location,
    required this.fav,
    required this.id,
  });

  final String image;
  final String productName;
  final String price;
  final String hours;
  final String location;
  final bool fav;
  final int id;

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        image: json["image"],
        productName: json["product_name"],
        price: json["price"],
        hours: json["hours"],
        location: json["location"],
        fav: json["is_fav"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "product_name": productName,
        "price": price,
        "hours": hours,
        "location": location,
        "fav": fav,
        "id": id,
      };
}

class CategoryModel {
  CategoryModel({
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        image: json["'image"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "'image": image,
        "text": text,
      };
}
