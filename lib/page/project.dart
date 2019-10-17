import 'package:fancy_android/http/data_util.dart';
import 'package:fancy_android/model/project_category.dart' as category;
import 'package:fancy_android/page/project_item.dart';
import 'package:fancy_android/util/size_util.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProjectPageState();
}

class ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController;

  static List<category.Data> categories = [];
  var _maxCachePageNums = 5;
  var _cachedPageNum = 0;

  @override
  void initState() {
    super.initState();
    getProjectCategory();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
            title: Container(
              height: SizeUtil.px(90),
              alignment: Alignment.center,
              child: Text(
                '项目',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.blue,
            bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: _buildTabs(),
            )),
        body: TabBarView(
          controller: tabController,
          children: _buildContent(),
        ),
      ),
    );
  }

  getProjectCategory() async {
    DataUtil.getProjectCategory().then((result) {
      setState(() {
        categories.clear();
        categories.addAll(result.data);
        if (null == tabController) {
          tabController = TabController(vsync: this, length: categories.length);
        }
      });
    });
  }

  List<Widget> _buildTabs() {
    return categories.map((category) {
      return Tab(
        text: category.name,
      );
    }).toList();
  }

  List<Widget> _buildContent() {
    return categories?.map((category) {
      return ProjectItem(
          page: 1, categoryId: category.id, keepAlive: _keepAlive());
    })?.toList();
  }

  bool _keepAlive() {
    if (_cachedPageNum < _maxCachePageNums) {
      _cachedPageNum++;
      return true;
    } else {
      return false;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
