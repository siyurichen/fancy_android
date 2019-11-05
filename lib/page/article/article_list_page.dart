import 'package:fancy_android/model/latest_article_model.dart' as article;
import 'package:fancy_android/page/article/article_item_page.dart';
import 'package:flutter/material.dart';

typedef Future<article.Data> RequestData(int page);

class ArticleListPage extends StatefulWidget {
  final Widget header;
  final RequestData request;
  final int itemType; //根据不同type绘制不同的ListView Item
  final bool showAppBar; //是否展示AppBar
  final int startPageIndex; //列表数据默认从哪一页开始（0 or 1）

  ArticleListPage(
      {Key key,
      this.header,
      @required this.request,
      @required this.itemType,
      this.showAppBar = true,
      this.startPageIndex = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller = new ScrollController();
  List<article.Datas> _list = [];
  String title = '';
  int pageIndex;
  String loadMoreText = ''; //加载更多或者到底文案
  int totalSize; //数据总条数
  bool showMore = false; //是否显示加载更多
  bool offState = false; //是否显示进入页面时的圆形进度条

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && _list.length == totalSize) {
        setState(() {
          showMore = false;
          loadMoreText = "亲爱的，到底了~";
        });
      } else if (maxScroll == pixel) {
        setState(() {
          showMore = true;
          loadMoreText = "正在加载更多数据...";
        });
        pageIndex++;
        _getArticle();
      }
    });
    pageIndex = (widget.startPageIndex == 0) ? 0 : widget.startPageIndex;
    _getArticle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int itemCount = _calculateItemCount();
    ListView listView = _buildListView(context, itemCount);
    RefreshIndicator refreshIndicator = RefreshIndicator(
      displacement: 10,
      onRefresh: () {
        pageIndex = 0;
        return _getArticle();
      },
      child: listView,
    );
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(title),
            )
          : null,
      body: Stack(
        children: <Widget>[
          refreshIndicator,
          Offstage(
            offstage: offState,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  _calculateItemCount() {
    return ((null == _list) ? 0 : _list.length) +
        (null == widget.header ? 0 : 1) +
        1;
  }

  Widget _buildListView(BuildContext context, int itemCount) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(context, index);
      },
      itemCount: itemCount,
      controller: _controller,
      //解决item太少不足一屏的时候不能下拉刷新的问题
      physics: new AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index == 0 && widget.header != null) {
      return widget.header;
    } else if (index - (null == widget.header ? 0 : 1) >= _list.length) {
      return _buildProgressMoreIndicator();
    } else {
      return ArticleItemPage(
        articleModel: _list[index - (null == widget.header ? 0 : 1)],
        itemType: widget.itemType,
      );
    }
  }

  Widget _buildProgressMoreIndicator() {
    return new Container(
      height: 50,
      child: Center(
        child: Text(loadMoreText,
            style: TextStyle(fontSize: 12, color: Colors.black38)),
      ),
    );
  }

  _getArticle() async {
    setState(() {
      widget.request(pageIndex).then((result) {
        setState(() {
          if (!showMore) {
            _list.clear();
          }
          _list.addAll(result.datas);
          title = _list[0]?.chapterName;
          totalSize = result?.total;
          showMore = false;
          offState = true;
          if (result.datas.length == 0) {
            loadMoreText = '亲爱的，到底了~';
          }
        });
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
