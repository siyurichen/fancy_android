import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/model/knowledge_system_detail_model.dart'
    as systemDetail;
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
  List<systemDetail.Datas> _list = [];
  String title = '';

  @override
  void initState() {
    super.initState();
    _getKnowledgeSystemDetail(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildListView(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(context, index);
      },
      itemCount: _list.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                _list[index]?.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 6),
              child: Text(DateUtil.getTimeDuration(_list[index]?.publishTime)),
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
    );
  }

  void _getKnowledgeSystemDetail(int page) {
    setState(() {
      DataUtil.getKnowledgeSystemDetail(page, widget.id).then((result) {
        setState(() {
          _list = result.datas;
          title = _list[0]?.chapterName;
        });
      });
    });
  }
}
