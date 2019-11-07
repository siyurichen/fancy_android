import 'package:fancy_android/http/api.dart';
import 'package:fancy_android/http/http_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool _collected;
  bool _offState = false;

  @override
  void initState() {
    super.initState();
    _collected = widget.isCollect;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          _buildWebView(),
          Offstage(
            offstage: _offState,
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onPageFinished: (url) {
        setState(() {
          _offState = true;
        });
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
    if (_collected) {
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
    String url = _collected
        ? "${Api.CANCEL_FAVORITE_ARTICLE_URL}$articleId/json"
        : "${Api.FAVORITE_ARTICLE_URL}$articleId/json";
    HttpMethods.getInstance().doOptionRequest(url: url).then((result) {
      setState(() {
        if (result == 0) {
          _collected = !_collected;
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
