import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserWebView extends StatefulWidget {
  final url;
  final title;

  BrowserWebView({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowserWebView();
}

class _BrowserWebView extends State<BrowserWebView> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
