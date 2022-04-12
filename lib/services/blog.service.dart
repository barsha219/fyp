import 'dart:developer';

import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/blog_models.dart';
import 'package:dio/dio.dart';

class BlogService {
  final Dio _dio = Dio();

  //  fetch all Services
  Future<List<Blog>> fetchAllBlogs() async {
    try {
      var response = (await _dio.get("${AppConfig.baseUrl}api/blog"));

      // log(response.data.toString());
      return List.from(
          response.data["blogs"].map((blog) => Blog.fromJson(blog)));
    } catch (error) {
      log(error.toString());
      throw "Error Fetching Blogs";
    }
  }

  //add category
  Future<void> addBlogs(String title, String description) async {
    try {
      var path = AppConfig.baseUrl + "api/blog/create";
      final response = await _dio.post(path, data: {
        "title": title,
        "description": description,
      });
      log(response.data.toString());
    } on DioError catch (e) {
      log(e.toString());
      throw e.response?.data["message"] ?? "Failed to Add Category";
    }
  }

  //delete category
  Future<bool> deleteBlogs(String id) async {
    try {
      var url = "https://beautystore-app.herokuapp.com/api/blog/delete?id=$id";
      var response = await _dio.delete(url, queryParameters: {"id": id});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Failed to Delete  Blog";
      }
    } on DioError catch (error) {
      log((error.response!.data).toString());
      throw "Failed to Deleting Blog";
    }
  }
}
