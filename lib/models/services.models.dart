import 'dart:convert';

import 'package:beauty_store/services/services.service.dart';

ServiceResponse serviceResponseFromJson(String str) =>
    ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) =>
    json.encode(data.toJson());

class ServiceResponse {
  ServiceResponse({
    required this.message,
    required this.services,
    required this.status,
  });

  String message;
  List<Services> services;
  int status;

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      ServiceResponse(
        services:
            List<Services>.from(json["data"].map((x) => Services.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(services.map((x) => x.toJson())),
        "status": status,
      };
}

class Services {
  Services({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Services.fromJson(json) => Services(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
