import 'dart:developer';

import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookingService {
  final Dio _dio = Dio();
  addBookings(BuildContext context, Map data) async {
    try {
      final response =
          await _dio.post(AppConfig.baseUrl + "api/bookings/add", data: data);
      log(response.data.toString());
      if (response.statusCode == 200) {
        // navigate to booking
      }
    } catch (e) {}
  }

  getUserBookings() async {
    final response = await _dio
        .get(AppConfig.baseUrl + "api/bookings/get", queryParameters: {
      'id': AuthService.instance.user?.id,
    });
    return response.data['data'];
  }

  fetchAllServiceOfThatDate(String serviceId, String date) async {
    final response = await _dio
        .get(AppConfig.baseUrl + "api/bookings/search", queryParameters: {
      "serviceId": serviceId,
      "date": date,
    });
    return response.data['bookings'];
  }
}
