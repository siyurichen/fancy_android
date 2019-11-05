import 'package:fancy_android/page/article/common_article_list_page.dart';
import 'package:fancy_android/page/browser_webView.dart';
import 'package:fancy_android/page/favorite/favorite_article_page.dart';
import 'package:fancy_android/page/login/login.dart';
import 'package:fancy_android/page/search/search_page.dart';
import 'package:fancy_android/model/latest_article_model.dart' as article;
import 'package:flutter/material.dart';

class NavigatorUtil {
  static navigatorWeb(BuildContext context, String url, String title) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new BrowserWebView(
          url: url,
          title: title,
        );
      }),
    );
  }

  static navigatorWebWithCollect(BuildContext context, String url, String title,
      bool isCollect, int articleId) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new BrowserWebView(
          url: url,
          title: title,
          isCollect: isCollect,
          articleId: articleId,
          hasFavoriteIcon: true,
        );
      }),
    );
  }

  static navigatorCommonArticle(BuildContext context, String title,
      int itemType, Future<article.Data> Function(int) request) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new CommonArticleListPage(
          request: request,
          title: title,
          itemType: itemType,
        );
      }),
    );
  }

  static navigatorSearch(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SearchPage();
    }));
  }

  static navigatorLogin(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  static navigatorFavoriteArticle(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new FavoriteArticlePage();
    }));
  }
}
