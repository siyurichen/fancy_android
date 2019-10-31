import 'package:dio/dio.dart';
import 'package:fancy_android/model/common_use_website_model.dart'
    as commonUseWebsiteModel;
import 'package:fancy_android/model/favorite_article_model.dart'
    as favoriteArticleModel;
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:fancy_android/model/hot_search_key_model.dart' as hotSearchKey;
import 'package:fancy_android/model/knowledge_system_model.dart' as system;
import 'package:fancy_android/model/latest_article_model.dart' as article;
import 'package:fancy_android/model/project_category_model.dart';
import 'package:fancy_android/model/we_chat_article_category.dart';
import 'package:fancy_android/util/sharedPreferences_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'api.dart';

class HttpMethods {
  static HttpMethods _instance;
  static Dio dio =
      new Dio(BaseOptions(baseUrl: Api.BASE_URL, connectTimeout: 15000));
  static const String GET = 'GET';
  static const String POST = 'POST';

  static HttpMethods getInstance() {
    if (_instance == null) {
      _instance = new HttpMethods();
    }
    return _instance;
  }

  HttpMethods() {
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

  Future sendRequest(
      String method, String url, Map<String, dynamic> params) async {
    var response;
    if (GET == method) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.post(url, queryParameters: params);
    }
    return response?.data;
  }

  ///获取首页Banner
  Future<banner.HomeBannerModel> getBanner() async {
    var response = await sendRequest(POST, Api.HOME_BANNER_URL, null);
    try {
      return banner.HomeBannerModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取项目分类
  Future<ProjectCategoryModel> getProjectCategory() async {
    var response = await sendRequest(GET, Api.PROJECT_CATEGORY_URL, null);
    try {
      return ProjectCategoryModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取体系
  Future<system.KnowledgeSystemModel> getKnowledgeSystem() async {
    var response;
    try {
      response = await sendRequest(GET, Api.KNOWLEDGE_SYSTEM_URL, null);
      return system.KnowledgeSystemModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///搜索热词
  Future<hotSearchKey.HotSearchKeyModel> getHotSearchKey() async {
    var response = await sendRequest(GET, Api.HOT_SEARCH_KEY_URL, null);
    try {
      return hotSearchKey.HotSearchKeyModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///常用网站
  Future<commonUseWebsiteModel.CommonUseWebsiteModel>
      getCommonUseWebsite() async {
    var response = await sendRequest(GET, Api.COMMON_USE_WEBSITE_URL, null);
    try {
      return commonUseWebsiteModel.CommonUseWebsiteModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///根据关键字搜索对应的文章
  Future<article.Data> searchArticle(String url, String keyName) async {
    var data = {'k': keyName};
    var response = await sendRequest(POST, url, data);
    try {
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取文章列表
  Future<article.Data> getArticle(String url) async {
    var response;
    try {
      response = await sendRequest(GET, url, null);
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取公众号分类
  Future<WeChatArticleCategory> getWeChatArticleCategory() async {
    var response =
        await sendRequest(GET, Api.WE_CHAT_ARTICLE_CATEGORY_URL, null);
    try {
      return WeChatArticleCategory.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///登录（需要将set-cookie中的值持久化的本地）
  Future login(String userName, String passWord) async {
    var map = {'username': userName, 'password': passWord};
    var response = await sendRequest(POST, Api.LOGIN_URL, map);
    try {
      return response;
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取收藏的文章
  Future<favoriteArticleModel.Data> favoriteArticleList(int page) async {
    var response = await sendRequest(
        GET, "${Api.FAVORITE_ARTICLE_LIST_URL}$page/json", null);
    try {
      return favoriteArticleModel.Data.fromJson(response['data']);
    } catch (error) {
      Fluttertoast.showToast(msg: response['errorMsg']);
      return response['errorMsg'];
    }
  }

  ///只返回成功或者失败的请求
  Future doOptionRequest({String url, Map<String, dynamic> params}) async {
    var response = await sendRequest(POST, url, params);
    try {
      return response['errorCode'];
    } catch (error) {
      return response['errorMsg'];
    }
  }
}
