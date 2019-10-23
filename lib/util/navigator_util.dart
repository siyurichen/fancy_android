import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/page/article/article_list_page.dart';
import 'package:fancy_android/page/browser_webView.dart';
import 'package:fancy_android/page/search/search_page.dart';
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

  static navigatorKnowledgeDetail(BuildContext context, int id) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new ArticleListPage(
          request: (page) {
            return HttpMethods.getArticle(
                "${Api.KNOWLEDGE_SYSTEM_DETAIL_URL}$page/json?cid=$id");
          },
          itemType: 1,
        );
      }),
    );
  }

  static navigatorSearchResult(BuildContext context, String keyName) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new ArticleListPage(
          request: (page) {
            return HttpMethods.searchArticle(
                "${Api.SEARCH_BY_HOT_KEY_URL}$page/json", keyName);
          },
          itemType: 1,
        );
      }),
    );
  }

  static navigatorSearch(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SearchPage();
    }));
  }
}
