import 'dart:async';

import 'package:dio/dio.dart';

class HttpClient {
  final String baseUrl = "http://phsar-samnong.com/api";
  Dio dio;

  HttpClient({this.dio}) {
    dio = dio ?? Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 300000;
  }
}
