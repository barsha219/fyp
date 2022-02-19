import 'dart:developer';
import 'package:beauty_store/meta/screens/home/home.dart';
import 'package:beauty_store/models/user.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

//singleton(single instance of a class) pattern for Auth service
class AuthService {
  User? user;
  static final AuthService instance =
      AuthService._internal(); //instance of a class

  factory AuthService() {
    return instance;
  }

  AuthService._internal();
  final _dio = Dio();

  login(String email, String password, BuildContext context) async {
    try {
      var response =
          await _dio.post("${AppConfig.baseUrl}api/auth/login/", data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        user = UserResponse.fromMap(response.data)
            .user; //assigning the value to user property of authservice
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ));
      } else {
        throw "Failed to Login";
      }
    } on DioError catch (e) {
      log(e.toString());
      throw e.response?.data["message"] ?? "Failed to Login";
    }
  }

  signup(BuildContext context,
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String address}) async {
    try {
      var response =
          await _dio.post("${AppConfig.baseUrl}api/auth/register/", data: {
        "name": name,
        "email": email,
        "password": password,
        "phoneNumber": phone,
        "address": address,
      });
      if (response.statusCode == 200) {
        user = UserResponse.fromMap(response.data).user;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        throw "Failed to Signup";
      }
    } on DioError catch (error) {
      throw error.response?.data["message"] ?? "Failed to Singup";
    }
  }
}
