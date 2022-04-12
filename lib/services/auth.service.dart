import 'dart:developer';
import 'package:beauty_store/models/user_models.dart';
import 'package:beauty_store/widgets/button_nav_bar.dart';
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
              builder: (context) => const Layout(),
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
            context, MaterialPageRoute(builder: (context) => const Layout()));
      } else {
        throw "Failed to Signup";
      }
    } on DioError catch (error) {
      throw error.response?.data["message"] ?? "Failed to Singup";
    }
  }

  logout() {
    user = User();
  }

  updateUserProfile(Map<String, dynamic> data) async {
    try {
      final response = await Dio().post(
        'https://beautystore-app.herokuapp.com/api/auth/update',
        data: {
          "userId": user?.id,
          "name": data["name"],
          "phoneNumber": data["phoneNumber"],
          "address": data["address"],
        },
      );
      if (response.statusCode == 200) {
        user = User.fromMap(response.data["user"]);
        log(response.data.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

final auth = AuthService();
