import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  EmptyWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(null == message ? '暂无数据' : message),
    );
  }
}
