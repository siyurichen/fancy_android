import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/util/sharedPreferences_util.dart';

class Http {
  static const String GET = 'GET';
  static const String POST = 'POST';
  static Map<String, String> headerMap;
  static Dio dio =
      new Dio(BaseOptions(baseUrl: Api.BASE_URL, connectTimeout: 15000));
  static bool isInit = false;

  static void _addInterceptor() {
    isInit = true;
    dio.interceptors
      ..add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ))
      ..add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        SharedPreferencesUtil.getCookies((cookies) {
          String cookie = cookies.toString();
          if (cookie != null && cookie.isNotEmpty) {
            options.headers
              ..addAll({
                'Cookie': cookie,
              });
          }
          return options;
        });
      }, onResponse: (Response response) async {
        var cookies = response.headers['Set-Cookie'];
        if (null != cookies && cookies.isNotEmpty) {
          SharedPreferencesUtil.saveCookies(cookies.toString());
        }
      }));
  }

  static Future requestWithHeader(
      String method, String url, Map<String, dynamic> params) async {
    _addInterceptor();
    var response;
    if (GET == method) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.post(url, queryParameters: params);
    }
    return response;
  }
}
