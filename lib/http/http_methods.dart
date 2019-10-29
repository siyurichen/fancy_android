import 'package:fancy_android/http/http.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

import 'api.dart';

class HttpMethods {
  ///获取首页Banner
  static Future<banner.HomeBannerModel> getBanner() async {
    var response =
        await Http.requestWithHeader(Http.POST, Api.HOME_BANNER_URL, null);
    try {
      return banner.HomeBannerModel.fromJson(response?.data);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取项目分类
  static Future<ProjectCategoryModel> getProjectCategory() async {
    var response =
        await Http.requestWithHeader(Http.GET, Api.PROJECT_CATEGORY_URL, null);
    try {
      return ProjectCategoryModel.fromJson(response?.data);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取体系
  static Future<system.KnowledgeSystemModel> getKnowledgeSystem() async {
    var response;
    try {
      response = await Http.requestWithHeader(
          Http.GET, Api.KNOWLEDGE_SYSTEM_URL, null);
      return system.KnowledgeSystemModel.fromJson(response?.data);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///搜索热词
  static Future<hotSearchKey.HotSearchKeyModel> getHotSearchKey() async {
    var response =
        await Http.requestWithHeader(Http.GET, Api.HOT_SEARCH_KEY_URL, null);
    try {
      return hotSearchKey.HotSearchKeyModel.fromJson(response?.data);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///常用网站
  static Future<commonUseWebsiteModel.CommonUseWebsiteModel>
      getCommonUseWebsite() async {
    var response = await Http.requestWithHeader(
        Http.GET, Api.COMMON_USE_WEBSITE_URL, null);
    try {
      return commonUseWebsiteModel.CommonUseWebsiteModel.fromJson(
          response?.data);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///根据关键字搜索对应的文章
  static Future<article.Data> searchArticle(String url, String keyName) async {
    var data = {'k': keyName};
    var response = await Http.requestWithHeader(Http.POST, url, data);
    try {
      return article.Data.fromJson(response?.data['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///获取文章列表
  static Future<article.Data> getArticle(String url) async {
    var response;
    try {
      response = await Http.requestWithHeader(Http.GET, url, null);
      return article.Data.fromJson(response?.data['data']);
    } catch (error) {
      return response?.data['errorMsg'];
    }
  }

  ///获取公众号分类
  static Future<WeChatArticleCategory> getWeChatArticleCategory() async {
    var response = await Http.requestWithHeader(
        Http.GET, Api.WE_CHAT_ARTICLE_CATEGORY_URL, null);
    try {
      return WeChatArticleCategory.fromJson(response?.data);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  ///登录（需要将set-cookie中的值持久化的本地）
  static Future login(String userName, String passWord) async {
    var map = {'username': userName, 'password': passWord};
    var response = await Http.requestWithHeader(Http.POST, Api.LOGIN_URL, map);
    try {
      return response?.data;
    } catch (error) {
      print(error);
      return error;
    }
  }

  ///获取收藏的文章
  static Future<favoriteArticleModel.Data> favoriteArticleList(int page) async {
    var response = await Http.requestWithHeader(
        Http.GET, "${Api.FAVORITE_ARTICLE_LIST_URL}$page/json", null);
    try {
      return favoriteArticleModel.Data.fromJson(response?.data['data']);
    } catch (error) {
      Fluttertoast.showToast(msg: response?.data['errorMsg']);
      return error;
    }
  }

  ///只返回成功或者失败的请求
  static Future doOptionRequest(String url) async {
    var response = await Http.requestWithHeader(Http.POST, url, null);
    try {
      return response?.data['errorCode'];
    } catch (error) {
      return Fluttertoast.showToast(msg: response?.data['errorMsg']);
    }
  }
}
