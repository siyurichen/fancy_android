import 'package:fancy_android/http/http_util.dart';
import 'package:fancy_android/model/home_banner.dart' as banner;
import 'package:fancy_android/model/latest_article.dart' as article;

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
}
