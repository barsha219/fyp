import 'dart:developer';

import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/category_models.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:dio/dio.dart';

class ProductService {
  final _dio = Dio();

//  fetch all products
  Future<List<Product>> fetchAllProduct() async {
    try {
      var response = (await _dio.get("${AppConfig.baseUrl}api/product/"));
      // if (response.statusCode == 200) {
      return List.from(response.data["products"]
          .map((product) => Product.fromJson(product)));
      // } else {
      //   throw "Error Fetching Products";
      // }
    } catch (error) {
      log(error.toString());
      throw "Error Fetching Products";
    }
  }

// fetch all categories
  Future<List<Category>> fetchAllProductCategory() async {
    try {
      var response = (await _dio.get("${AppConfig.baseUrl}api/category/all"));
      log(response.data.toString());
      return List.from(response.data["categories"]
          .map((category) => Category.fromJson(category)));
    } catch (e) {
      // log(e.toString());
      throw e.toString();
    }
  }
}

//  Future<List<Category>> fetchAllProductCategory() async {
//     try {
//       var response = (await Dio().get("${AppConfig.baseUrl}api/categor/all"));
//       return List.from(response.data['category']
//           .map((category) => Category.fromJson(category)));
//     } catch (e) {
//       log(e.toString());
//       throw e.toString();
//     }
//   }