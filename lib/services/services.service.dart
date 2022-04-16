import 'dart:developer';
import 'dart:io';
import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/services.models.dart';
import 'package:dio/dio.dart';

class ServicesItems {
  final Dio _dio = Dio();

  Services? services;

  //   converting into singleton so that we can use the instance of class where needed
  static final ServicesItems instance =
      ServicesItems._internal(); //instance of a class

  factory ServicesItems() {
    return instance;
  }

  ServicesItems._internal();

  //  fetch all Services
  Future<List<Services>> fetchAllServices() async {
    try {
      var response = (await _dio.get("${AppConfig.baseUrl}api/services/"));

      // log(response.data.toString());
      return List.from(
          response.data["data"].map((service) => Services.fromJson(service)));
    } catch (error) {
      log(error.toString());
      throw "Error Fetching Services";
    }
  }

  Future<void> deleteBooking(String id) async {
    try {
      final response = await _dio
          .delete(AppConfig.baseUrl + "api/bookings/delete", queryParameters: {
        'id': id,
      });
      log(response.data.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> addService(
      {required String serviceName,
      required String price,
      required File imageUrl}) async {
    try {
      final image = await uploadFile(file: imageUrl);
      var response = await _dio.post(AppConfig.baseUrl + "api/services/add",
          data: {'serviceName': serviceName, 'price': price, 'image': image});
      if (response.statusCode == 200) {
        return image;
      } else {
        throw "Failed to upload image";
      }
    } catch (error) {
      log(error.toString());
      throw "Failed to Add Service";
    }
  }

  // Future fetchServiceById(String id) async {
  //   try {
  //     var data =
  //         (await _dio.get("${AppConfig.baseUrl}api/services/service?id=$id"))
  //             .data;
  //     return Service.fromMap(data["data"]);
  //   } catch (e) {
  //     log(e.toString());
  //     throw "Failed to Fetch Service";
  //   }
  // }

  Future<bool> deleteService(String id) async {
    try {
      var response = await _dio.delete(
          "${AppConfig.baseUrl}api/services/delete",
          queryParameters: {"id": id});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Error Deleting Service";
      }
    } catch (error) {
      throw "Error Deleting Service";
    }
  }

  Future<String> uploadFile({required File file}) async {
    try {
      FormData data = FormData.fromMap(
          {"imageUrl": await MultipartFile.fromFile(file.path)});
      var url = AppConfig.baseUrl + "api/upload/imageUrl";
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioError catch (e) {
      log(e.response.toString());
      throw "Failed to Upload File.";
    }
  }
}
