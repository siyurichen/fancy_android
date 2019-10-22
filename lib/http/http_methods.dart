import 'package:fancy_android/http/http.dart';
import 'package:fancy_android/model/common_use_website_model.dart'
    as commonUseWebsiteModel;
import 'package:fancy_android/model/home_banner_model.dart' as banner;
import 'package:fancy_android/model/hot_search_key_model.dart' as hotSearchKey;
import 'package:fancy_android/model/knowledge_system_model.dart' as system;
import 'package:fancy_android/model/knowledge_system_detail_model.dart'
    as systemDetail;
import 'package:fancy_android/model/latest_article_model.dart' as article;
import 'package:fancy_android/model/project_category_model.dart';
import 'package:fancy_android/model/project_model.dart' as project;
import 'package:fancy_android/model/search_result_model.dart' as searchResult;
import 'package:fancy_android/page/search/search_result_page.dart';

import 'api.dart';

class HttpMethods {
  //获取最新首页最新文章
  static Future<article.Data> getLatestArticle(int page) async {
    var response = await Http.get("${Api.LATEST_ARTICLE_URL}$page/json", null);
    try {
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取最新首页最新项目
  static Future<article.Data> getLatestArticleProject(int page) async {
    var response =
        await Http.get("${Api.LATEST_ARTICLE_PROJECT_URL}$page/json", null);
    try {
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

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

  //获取项目
  static Future<project.Data> getProject(int page, int categoryId) async {
    var response;
    try {
      response =
          await Http.get("${Api.PROJECT_URL}$page/json?cid=$categoryId", null);

      return project.Data.fromJson(response['data']);
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

  //获取体系分类下的文章
  static Future<systemDetail.Data> getKnowledgeSystemDetail(
      int page, int id) async {
    var response;
    try {
      response = await Http.get(
          "${Api.KNOWLEDGE_SYSTEM_DETAIL_URL}$page/json?cid=$id", null);
      return systemDetail.Data.fromJson(response['data']);
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
  static Future<searchResult.SearchResultModel> searchArticle(
      int page, String keyName) async {
    var data={'k':keyName};
    var response =
        await Http.post("${Api.SEARCH_BY_HOT_KEY_URL}$page/json", data);
    try {
      return searchResult.SearchResultModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }
}
