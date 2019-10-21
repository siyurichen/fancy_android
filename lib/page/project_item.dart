import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:fancy_android/model/project.dart' as project;

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
      if (result.datas.length <= 0) return;
      setState(() {
        projects = result.datas;
      });
    });
  }

  Widget _buildPage() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(projects[index]);
        },
        itemCount: projects.length,
      ),
    );
  }

  Widget _buildItem(project.Datas project) {
    return Card(
        elevation: 5,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                _buildItemLeft(project),
                _buildItemRight(project),
              ],
            ),
          ),
          onTap: () {
            _onTap(project);
          },
        ));
  }

  void _onTap(project.Datas project) {
    print("mikechen:" + project.author);
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              project.desc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: <Widget>[
                Text(
                  DateUtil.getTimeDuration(project.publishTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    project.author,
                    style: TextStyle(
                      fontSize: 12,
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
        margin: EdgeInsets.only(left: 5),
        width: 60,
        height: 100,
        child: FadeInImage.assetNetwork(
          placeholder: '',
          image: project.envelopePic,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
