import 'dart:convert';

ServiceResponse serviceResponseFromJson(String str) =>
    ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) =>
    json.encode(data.toJson());

class ServiceResponse {
  ServiceResponse({
    this.message,
    this.services,
    this.status,
  });

  String? message;
  List<Services>? services;
  int? status;

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      ServiceResponse(
        services:
            List<Services>.from(json["data"].map((x) => Services.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(services!.map((x) => x.toJson())),
        "status": status,
      };
}

class Services {
  Services({
    this.id,
    this.serviceName,
    this.price,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? serviceName;
  int? price;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Services.fromJson(json) => Services(
        id: json["_id"],
        serviceName: json["serviceName"],
        price: json["price"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "serviceName": serviceName,
        "price": price,
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
