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
  _LoadMoreWidgetState createState() => new _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50,
      child: widget.showLoadMoreItem
          ? new Center(
              child: widget.showNoMoreData
                  ? Text(
                      '亲爱的，到底了~',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            '正在加载中...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          : null,
    );
  }
}
