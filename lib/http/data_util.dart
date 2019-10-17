import 'package:fancy_android/http/http_util.dart';
import 'package:fancy_android/model/home_banner.dart' as banner;
import 'package:fancy_android/model/knowledge_system_model.dart' as system;
import 'package:fancy_android/model/latest_article.dart' as article;
import 'package:fancy_android/model/project.dart' as project;
import 'package:fancy_android/model/project_category.dart';

import 'api.dart';

class DataUtil {
  //获取最新首页最新文章
  static Future<article.Data> getLatestArticle(int page) async {
    var response =
        await HttpUtil.get("${Api.LATEST_ARTICLE_URL}$page/json", null);
    try {
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取最新首页最新项目
  static Future<article.Data> getLatestArticleProject(int page) async {
    var response =
        await HttpUtil.get("${Api.LATEST_ARTICLE_PROJECT_URL}$page/json", null);
    try {
      return article.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取首页Banner
  static Future<banner.HomeBanner> getBanner() async {
    var response = await HttpUtil.post(Api.HOME_BANNER_URL, null);
    try {
      return banner.HomeBanner.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取项目分类
  static Future<ProjectCategory> getProjectCategory() async {
    var response = await HttpUtil.get(Api.PROJECT_CATEGORY_URL, null);
    try {
      return ProjectCategory.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取项目
  static Future<project.Data> getProject(int page, int categoryId) async {
    var response;
    try {
      response = await HttpUtil.get(
          "${Api.PROJECT_URL}$page/json?cid=$categoryId", null);

      return project.Data.fromJson(response['data']);
    } catch (error) {
      return response['errorMsg'];
    }
  }

  //获取体系
  static Future<system.KnowledgeSystemModel> getKnowledgeSystem() async {
    var response;
    try {
      response = await HttpUtil.get(Api.KNOWLEDGE_SYSTEM_URL, null);
      return system.KnowledgeSystemModel.fromJson(response);
    } catch (error) {
      return response['errorMsg'];
    }
  }
}
