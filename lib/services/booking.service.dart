import 'dart:developer';

import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/bookings.dart';
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
    } catch (e) {
      log(e.toString());
    }
  }

  getUserBookings() async {
    try {
      final response = await _dio
          .get(AppConfig.baseUrl + "api/bookings/user/get/", queryParameters: {
        'id': AuthService.instance.user?.id,
      });
      log(response.data.toString());
      return BookingsData.fromJson(response.data).bookings!.toList();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Bookings>> fetchAllServiceOfThatDate(
      String serviceId, String date) async {
    final response = await _dio
        .get(AppConfig.baseUrl + "api/bookings/search", queryParameters: {
      "serviceId": serviceId,
      "date": date,
    });
    return List.from(
        response.data['bookings'].map((data) => Bookings.fromJson(data)));
  }
}
