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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
