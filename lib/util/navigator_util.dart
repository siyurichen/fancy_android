import 'package:fancy_android/page/browser_webView.dart';
import 'package:fancy_android/page/KnowledgeSystem/knowledge_detail.dart';
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
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new KnowledgeDetail(
        id: id,
      );
    }));
  }
}
