import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/project.dart' as project;
import 'package:fancy_android/util/size_util.dart';

class ProjectItem extends StatefulWidget {
  final int page;
  final int categoryId;
  final bool keepAlive;

  ProjectItem({Key key, this.page, this.categoryId, this.keepAlive = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ProjectItemState();
  }
}

class ProjectItemState extends State<ProjectItem>
    with AutomaticKeepAliveClientMixin {
  static List<project.Datas> projects = [];

  @override
  void initState() {
    super.initState();
    getProject(widget.page, widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
    );
  }

  getProject(int page, int categoryId) async {
    DataUtil.getProject(page, categoryId).then((result) {
      setState(() {
        projects = result.datas;
      });
    });
  }

  Widget _buildPage() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(SizeUtil.px(20)),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(projects[index]);
        },
        itemCount: projects.length,
      ),
    );
  }

  Widget _buildItem(project.Datas project) {
    return Card(
      elevation: SizeUtil.px(5),
      child: Container(
        padding: EdgeInsets.all(SizeUtil.px(20)),
        child: Row(
          children: <Widget>[
            _buildItemLeft(project),
            _buildItemRight(project),
          ],
        ),
      ),
    );
  }

  Widget _buildItemLeft(project.Datas project) {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              project.title,
              style: TextStyle(
                fontSize: SizeUtil.px(32),
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: SizeUtil.px(10)),
            child: Text(
              project.desc,
              style: TextStyle(
                fontSize: SizeUtil.px(28),
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: SizeUtil.px(10)),
            child: Row(
              children: <Widget>[
                Text(
                  DateUtil.getTimeDuration(project.publishTime),
                  style: TextStyle(
                    fontSize: SizeUtil.px(24),
                    color: Colors.black54,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: SizeUtil.px(10)),
                  child: Text(
                    project.author,
                    style: TextStyle(
                      fontSize: SizeUtil.px(24),
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRight(project.Datas project) {
    return Expanded(
      flex: 1,
      child: Container(
        width: SizeUtil.px(60),
        height: SizeUtil.px(200),
        child: FadeInImage.assetNetwork(
          placeholder: 'images/icon_place_holder.png',
          image: project.envelopePic,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
