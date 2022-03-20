import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String comicResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.products,
    this.message,
    this.status,
  });

  List<Product>? products;
  String? message;
  int? status;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        products: json["data"] != null
            ? List<Product>.from(json["data"].map((x) => Product.fromJson(x)))
            : null,
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": products != null
            ? List<dynamic>.from(products!.map((x) => x.toJson()))
            : null,
        "message": message,
        "status": status,
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.image,
    this.category,
    this.description,
  });

  String? id;
  String? name;
  int? price;
  String? image;
  String? category;
  String? description;

  factory Product.fromJson(json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        category: json["category"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "image": image,
        "category": category,
        "description": description,
      };
}
