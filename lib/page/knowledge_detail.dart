import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/model/knowledge_system_detail_model.dart'
    as systemDetail;
import 'package:fancy_android/util/NavigatorUtil.dart';
import 'package:fancy_android/util/date_util.dart';
import 'package:flutter/material.dart';

class KnowledgeDetail extends StatefulWidget {
  final int id;

  KnowledgeDetail({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new KnowledgeDetailState();
  }
}

class KnowledgeDetailState extends State<KnowledgeDetail> {
  ScrollController _controller = new ScrollController();
  List<systemDetail.Datas> _list = [];
  String title = '';
  int pageIndex = 0;
  String loadMoreText = '';
  int totalSize;
  bool showMore = false;
  bool offState = false; //是否显示进入页面时的圆形进度条

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && _list.length == totalSize) {
        setState(() {
          loadMoreText = "亲爱的，到底了~";
        });
      } else if (maxScroll == pixel) {
        setState(() {
          showMore = true;
          loadMoreText = "正在加载更多数据...";
        });
        pageIndex++;
        print("mikechen loadmore pageindex:" + pageIndex.toString());
        _getKnowledgeSystemDetail(pageIndex);
      }
    });
    _getKnowledgeSystemDetail(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    ListView listView = _buildListView(context);
    RefreshIndicator refreshIndicator = RefreshIndicator(
      displacement: 10,
      onRefresh: () {
        pageIndex = 0;
        return _getKnowledgeSystemDetail(pageIndex);
      },
      child: listView,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
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
        ));
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

  _getKnowledgeSystemDetail(int page) async {
    setState(() {
      DataUtil.getKnowledgeSystemDetail(page, widget.id).then((result) {
        setState(() {
          if (!showMore) {
            _list.clear();
          }
          _list.addAll(result.datas);
          title = _list[0]?.chapterName;
          totalSize = result?.total;
          showMore = false;
          offState = true;
        });
      });
    });
  }
}
