import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt!.toIso8601String(),
        "UpdatedAt": updatedAt!.toIso8601String(),
      };
}
