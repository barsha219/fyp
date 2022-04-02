import 'dart:developer';
import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/services.models.dart';
import 'package:dio/dio.dart';

class ServicesItems {
  final Dio _dio = Dio();

  //  fetch all Services
  Future<List<Services>> fetchAllServices() async {
    try {
      var response = (await _dio.get("${AppConfig.baseUrl}api/services/"));

      log(response.data.toString());
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

  // Future<bool> addService(Service service) async {
  //   try {
  //     var response = await _dio.post(
  //       "${AppConfig.baseUrl}api/services/add",
  //       data: service.toMap(),
  //     );
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     throw "Failed to Add Service";
  //   }
  // }

  // Future<bool> deleteService(String id) async {
  //   try {
  //     var response = await _dio.delete(
  //         "${AppConfig.baseUrl}api/services/delete",
  //         queryParameters: {"id": id});
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw "Error Deleting Service";
  //     }
  //   } catch (error) {
  //     throw "Error Deleting Service";
  //   }
  // }

}
