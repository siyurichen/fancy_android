import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fancy_android/http/api.dart';

var dio = new Dio(BaseOptions(baseUrl: Api.BASE_URL, connectTimeout: 15000));

class Http {
  static Future get(String url, Map<String, dynamic> params) async {
    var response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  static Future post(String url, Map<String, dynamic> params) async {
    var response;
    if (params != null) {
      response = await dio.post(url, queryParameters: params);
    } else {
      response = await dio.post(url);
    }
    return response.data;
  }
}
