import 'package:flutter/material.dart';

class LoadMoreWidget extends StatefulWidget {
  final bool showNoMoreData;
  final bool showLoadMoreItem;

  LoadMoreWidget({
    Key key,
    this.showNoMoreData = false,
    this.showLoadMoreItem = true,
  }) : super(key: key);

  @override
  LoadMoreWidgetState createState() => new LoadMoreWidgetState();
}

class LoadMoreWidgetState extends State<LoadMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50,
      child: widget.showLoadMoreItem
          ? new Center(
              child: widget.showNoMoreData
                  ? Text('亲爱的，到底了~',
                      style: TextStyle(fontSize: 12, color: Colors.black38))
                  : new CircularProgressIndicator(),
            )
          : null,
    );
  }
}
