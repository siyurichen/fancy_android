import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/latest_article_model.dart' as articleModel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserWebView extends StatefulWidget {
  final url;
  final title;
  final bool isCollect;
  final int articleId;
  final bool hasFavoriteIcon;

  BrowserWebView({
    Key key,
    @required this.url,
    @required this.title,
    this.isCollect = false,
    this.articleId,
    this.hasFavoriteIcon = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowserWebView();
}

class _BrowserWebView extends State<BrowserWebView> {
  WebViewController _webViewController;
  bool collected;

  @override
  void initState() {
    super.initState();
    collected = widget.isCollect;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[_buildFavoriteIcon()],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onPageFinished: (url) {
          _webViewController.evaluateJavascript(_flutterCallJsString());
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("sce")) {
            print("即将打开" + request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        javascriptChannels: <JavascriptChannel>[
          _jSCallFlutter(context),
        ].toSet(),
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return widget.hasFavoriteIcon
        ? GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10),
              child: _buildIcon(),
            ),
            onTap: () {
              cancelOrFavoriteArticle(widget.articleId);
            },
          )
        : Container();
  }

  Widget _buildIcon() {
    if (collected) {
      return Icon(
        Icons.favorite,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.favorite_border,
      );
    }
  }

  ///取消或者收藏文章
  cancelOrFavoriteArticle(int articleId) async {
    String url = collected
        ? "${Api.CANCEL_FAVORITE_ARTICLE_URL}$articleId/json"
        : "${Api.FAVORITE_ARTICLE_URL}$articleId/json";
    HttpMethods.getInstance().doOptionRequest(url).then((result) {
      setState(() {
        if (result == 0) {
          collected = !collected;
        }
      });
    });
  }

  JavascriptChannel _jSCallFlutter(BuildContext context) {
    return JavascriptChannel(
        name: "backPage",
        onMessageReceived: (JavascriptMessage message) {
          print("参数：" + message.message);
        });
  }

  String _flutterCallJsString() {
    return "";
  }

  @override
  void dispose() {
    super.dispose();
  }
}
