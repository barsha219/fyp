import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((e) => Category.fromJson(e)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class Category {
  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "UpdatedAt": updatedAt!.toIso8601String(),
      };
}
