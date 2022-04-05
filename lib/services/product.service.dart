import 'dart:developer';
import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/models/category_models.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:dio/dio.dart';
import 'dart:io';

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

// add products
  Future addProduct(
      {required String name,
      required String price,
      required String description,
      required File file,
      required String category}) async {
    try {
      var url = AppConfig.baseUrl + "api/product/add";
      final image = await uploadFile(file: file);
      final response = await _dio.post(url, data: {
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "category": category
      });
      return url;
    } catch (e) {
      log(e.toString());
      throw "Failed to add Product";
    }
  }

//delete products
  Future<bool> deleteProduct(String id) async {
    try {
      var response = await _dio
          .delete("${AppConfig.baseUrl}api/product/delete/", queryParameters: {
        "id": id,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Failed to Delete  Product";
      }
    } catch (error) {
      throw "Failed to Delete  Product";
    }
  }

// fetch all categories
  Future<List<Category>> fetchAllProductCategory() async {
    try {
      var response = (await _dio.get("${AppConfig.baseUrl}api/category/all"));
      // log(response.data.toString());
      return List.from(response.data["categories"]
          .map((category) => Category.fromJson(category)));
    } catch (e) {
      // log(e.toString());
      // throw e.toString();
      throw "Failed to get category";
    }
  }

  //add category
  Future<void> addCategory(String name) async {
    try {
      var path = AppConfig.baseUrl + "api/category/add";
      final response = await _dio.post(path, data: {"name": name});
      log(response.data.toString());
    } on DioError catch (e) {
      log(e.toString());
      throw e.response?.data["message"] ?? "Failed to Add Category";
    }
  }

  //delete category
  Future<bool> deleteCategory(String id) async {
    try {
      var response = await _dio
          .delete("${AppConfig.baseUrl}api/category/delete", queryParameters: {
        "id": id,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Failed to Delete  Category";
      }
    } catch (error) {
      throw "Failed to Deleting Category";
    }
  }
  // deleteCategory(String id) async {
  //   try {
  //     var path = AppConfig.baseUrl + "api/category/delete?id=$id";
  //     log(id.toLowerCase());
  //     final response = await _dio.delete(path, queryParameters: {
  //       'id': id,
  //     });
  //     log(response.data.toString());
  //   } catch (e) {
  //     log(e.toString());
  //     throw "Failed to delete";
  //   }
  // }

  // Future<bool> deleteCategory(String id) async {
  //   try {
  //     var response = await _dio.delete(
  //         "${AppConfig.baseUrl}api/category/delete",
  //         queryParameters: {"id": id});
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw "Error Delete Category";
  //     }
  //   } catch (error) {
  //     throw " Err Can't delete Category";
  //   }
  // }

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
