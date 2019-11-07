import 'package:fancy_android/page/widget/custom_list_view/default_load_widget.dart';
import 'package:fancy_android/page/widget/custom_list_view/load_more_widget.dart';
import 'package:flutter/material.dart';

typedef PageRequest<T> = Future<List<T>> Function(int page, int pageSize);
typedef ItemBuilder<T> = Widget Function(List<T> list, int position);

class CustomListView<T> extends StatefulWidget {
  final Widget header;
  final PageRequest<T> pageRequest;
  final ItemBuilder<T> itemBuilder;
  final int pageSize;
  final int page;
  final bool enableLoadMore;
  final bool enableRefresh;

  CustomListView({
    Key key,
    this.header,
    this.pageRequest,
    this.itemBuilder,
    this.pageSize = 20,
    this.page = 0,
    this.enableLoadMore = true,
    this.enableRefresh = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView<T>> {
  bool _enableLoadMore;
  int _page;
  List<T> _list = new List();

  ScrollController _scrollController;
  bool _showLoading = false; //是否正在加载数据的标志
  bool _showNoMoreData = false; //是否加载完全部数据

  Future _future;
  FutureBuilder<List<T>> _futureBuilder;

  @override
  void initState() {
    _enableLoadMore = widget.enableLoadMore;
    _page = widget.page;

    _future = loadData(widget.page, widget.pageSize);
    _futureBuilder = buildFutureBuilder();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixel = _scrollController.position.pixels;

      if (pixel == maxScroll) {
        if (!_showLoading && !_showNoMoreData) {
          _showLoading = true;
          _page++;
          loadMore();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _futureBuilder,
    );
  }

  FutureBuilder<List<T>> buildFutureBuilder() {
    return new FutureBuilder<List<T>>(
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _showLoading = false;
          {
            if (snapshot.hasData) {
              if (_page == widget.page) {
                _list.addAll(snapshot.data);
              }

              int itemCount = ((null == _list) ? 0 : _list.length) +
                  (null != widget.header ? 1 : 0) +
                  (_enableLoadMore ? 1 : 0);

              return new RefreshIndicator(
                  child: new ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller:
                        widget.enableLoadMore ? _scrollController : null,
                    itemBuilder: (context, index) {
                      if (index == 0 && null != widget.header) {
                        return widget.header;
                      } else if (_enableLoadMore &&
                          (index - (null == widget.header ? 0 : 1)) >=
                              _list.length) {
                        return new LoadMoreWidget(
                          showLoadMoreItem: _list.length >= widget.pageSize,
                          showNoMoreData: _showNoMoreData,
                        );
                      } else {
                        return widget.itemBuilder(
                            _list, index - (null == widget.header ? 0 : 1));
                      }
                    },
                    itemCount: itemCount,
                  ),
                  onRefresh: refresh);
            } else {
              return Container();
            }
          }
        } else {
          _showLoading = true;
          return new DefaultLoadWidget();
        }
      },
      future: _future,
    );
  }

  Future refresh() async {
    if (!widget.enableRefresh) {
      return;
    }
    if (_showLoading) {
      return;
    }

    _list.clear();
    setState(() {
      _showLoading = true;
      _showNoMoreData = false;
      _page = widget.page;
      _future = loadData(widget.page, widget.pageSize);
      _futureBuilder = buildFutureBuilder();
    });
  }

  void loadMore() async {
    loadData(_page, widget.pageSize).then((List<T> data) {
      setState(() {
        _showLoading = false;

        _list.addAll(data);
        _futureBuilder = buildFutureBuilder();
        _showNoMoreData = data.length == 0;
      });
    });
  }

  Future<List<T>> loadData(int page, int pageSize) async {
    return await widget.pageRequest(page, pageSize);
  }
}
