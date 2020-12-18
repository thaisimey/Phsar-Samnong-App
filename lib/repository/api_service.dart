import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:phsar_samnong/model/detail/detail.dart';
import 'file:///D:/Flutter/phsar_samnong/lib/model/category/category.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/repository/http_client.dart';

class ApiService {
  static Dio _dio = Dio();
  static HttpClient httpClient = HttpClient(dio: _dio);

  static Future<List<Category>> getCategories() async {
    try {
      Response response = await httpClient.dio.get("/categories");
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(response.data);

      print("response ${response}");

      return categoryResponse.data;
    } on DioError catch (e) {
      print("error ${e.message}");
    } catch (e) {
      print("errror ${e}");
      throw Exception(e);
    }
  }

  static Future<List<Item>> getProduct(int categoryID,int page,{int limit}) async {
    try {
      Response response = await httpClient.dio.get("/categories/${categoryID}/products",
        queryParameters: {
          'page' : page,
          'limit' : limit
        }

      );
      ItemResponse itemResponse =
          ItemResponse.fromJson(response.data);

      print("response ${response}");

      return itemResponse.data;

    } on DioError catch (e) {
      print("error ${e.message}");
    } catch (e) {
      print("errror ${e}");
      throw Exception(e);
    }
  }

  static Future<List<Item>> getSearch(String keyword,int page,{int limit}) async {
    try {
      Response response = await httpClient.dio.get("/products",
        queryParameters: {
          'keyword' : keyword,
          'page' : page,
          'limit' : limit
        }

      );
      ItemResponse itemResponse =
          ItemResponse.fromJson(response.data);

      // print("response ${response}");

      return itemResponse.data;

    } on DioError catch (e) {
      print("error ${e.message}");
    } catch (e) {
      print("errror ${e}");
      throw Exception(e);
    }
  }

  static Future<Detail> getProductDetail(int productID) async {
    try {
      Response response = await httpClient.dio.get("/products/${productID}");
      DetailResponse detailResponse = DetailResponse.fromJson(response.data);
      print("detail ${detailResponse.data}");
      return detailResponse.data;
    } on DioError catch (e) {
      print("error ${e.message}");
    } catch (e) {
      print("errror ${e}");
      throw Exception(e);
    }
  }




  
}
