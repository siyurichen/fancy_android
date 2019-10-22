import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/search_result_model.dart'
    as searchResultModel;
import 'package:fancy_android/util/date_util.dart';
import 'package:fancy_android/util/navigator_util.dart';

import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  final String keyName;

  SearchResultPage({Key key, @required this.keyName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new SearchResultPageState();
}

class SearchResultPageState extends State<SearchResultPage> {
  ScrollController _controller = new ScrollController();

  Map<String, String> params = Map();
  int pageIndex = 0;
  String loadMoreText = ''; //加载更多或者到底文案
  int totalSize; //数据总条数
  bool showMore = false; //是否显示加载更多
  bool offState = false; //是否显示进入页面时的圆形进度条
  List<searchResultModel.Datas> _list = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel) {
        if (_list.length == totalSize) {
          setState(() {
            showMore = false;
            loadMoreText = '亲爱的，到底了~';
          });
        } else {
          {
            setState(() {
              showMore = true;
              loadMoreText = '正在加载更多数据...';
            });
            pageIndex++;
            searchArticle();
          }
        }
      }
    });
    searchArticle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ListView listView = _buildListView(context);
    RefreshIndicator refreshIndicator = RefreshIndicator(
      displacement: 10,
      onRefresh: () {
        pageIndex = 0;
        return searchArticle();
      },
      child: listView,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keyName),
      ),
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

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(context, index);
      },
      itemCount: _list.length + 1,
      controller: _controller,
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index < _list.length) {
      return _buildItem(context, index);
    }
    return _buildProgressMoreIndicator();
  }

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      elevation: 5,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  _list[index]?.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 6),
                child:
                    Text(DateUtil.getTimeDuration(_list[index]?.publishTime)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 6),
                child: Text(_list[index].superChapterName +
                    '/' +
                    _list[index].chapterName),
              ),
            ],
          ),
        ),
        onTap: () {
          NavigatorUtil.navigatorWeb(
              context, _list[index]?.link, _list[index]?.title);
        },
      ),
    );
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

  searchArticle() async {
    HttpMethods.searchArticle(pageIndex, widget.keyName).then((result) {
      setState(() {
        if (!showMore) {
          _list.clear();
        }
        _list.addAll(result.data.datas);
        totalSize = result?.data?.total;
        showMore = false;
        offState = true;
        if (result.data.datas.length == 0) {
          loadMoreText = '亲爱的，到底了~';
        }
      });
    });
  }
}
