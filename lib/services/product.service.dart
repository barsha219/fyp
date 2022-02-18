import 'dart:developer';

import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  Future<List<Product>> fetchProduct() async {
    try {
      var response = (await Dio().get("${AppConfig.baseUrl}api/product/"));
      return List.from(response.data['products']
          .map((product) => Product.fromJson(product)));
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  // fetchAllProduct() async {
  //   try {
  //     var response = await Dio().get("${AppConfig.baseUrl}api/product/");
  //     if (response.statusCode == 200) {
  //       return response.data["products"]
  //           .map((product) => Product.fromJson(product))
  //           .toList();
  //     } else {
  //       throw "Error Fetching Products";
  //     }
  //   } catch (error) {
  //     log(error.toString());
  //     throw "Error Fetching Products";
  //   }
  // }
}
