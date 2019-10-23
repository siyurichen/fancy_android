import 'package:fancy_android/http/http.dart';
import 'package:fancy_android/model/common_use_website_model.dart'
    as commonUseWebsiteModel;
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:fancy_android/model/hot_search_key_model.dart' as hotSearchKey;
import 'package:fancy_android/model/knowledge_system_model.dart' as system;
import 'package:fancy_android/model/latest_article_model.dart' as article;
import 'package:fancy_android/model/project_category_model.dart';

import 'api.dart';

class HttpMethods {
  //获取首页Banner
  static Future<banner.HomeBannerModel> getBanner() async {
    var response = await Http.post(Api.HOME_BANNER_URL, null);
    try {
      return banner.HomeBannerModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取项目分类
  static Future<ProjectCategoryModel> getProjectCategory() async {
    var response = await Http.get(Api.PROJECT_CATEGORY_URL, null);
    try {
      return ProjectCategoryModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取体系
  static Future<system.KnowledgeSystemModel> getKnowledgeSystem() async {
    var response;
    try {
      response = await Http.get(Api.KNOWLEDGE_SYSTEM_URL, null);
      return system.KnowledgeSystemModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //搜索热词
  static Future<hotSearchKey.HotSearchKeyModel> getHotSearchKey() async {
    var response = await Http.get(Api.HOT_SEARCH_KEY_URL, null);
    try {
      return hotSearchKey.HotSearchKeyModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //常用网站
  static Future<commonUseWebsiteModel.CommonUseWebsiteModel>
      getCommonUseWebsite() async {
    var response = await Http.get(Api.COMMON_USE_WEBSITE_URL, null);
    try {
      return commonUseWebsiteModel.CommonUseWebsiteModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //根据关键字搜索对应的文章
  static Future<article.Data> searchArticle(String url, String keyName) async {
    var data = {'k': keyName};
    var response = await Http.post(url, data);
    try {
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取文章列表
  static Future<article.Data> getArticle(String url) async {
    var response;
    try {
      response = await Http.get(url, null);
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }
}
